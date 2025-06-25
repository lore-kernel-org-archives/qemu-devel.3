Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59872C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 19:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUVcP-00056T-0Q; Wed, 25 Jun 2025 15:17:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUVcL-00055X-6U
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uUVcJ-00078c-0l
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 15:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750879021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kw0DlxWGd8ypdEKrTwqtxV3qjtemMX85iv2o6/m6TKA=;
 b=GAm+/ijTUhPWh3ub7kvk/WbKRZF2Skb2dPo+mArbTKea9YBf+KmeaVniEv6x6RolqVD2UZ
 CfFdxtqe1mhHNn+pFA+H4B4+pmKuT7Iubq8ElPSMXhBEB+gQID4Lrdb0YdBOgufQVJkXyf
 yaCSLlN42i3w7u2F9O0Iw2UZ5tBuwVQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-OC-ucnk3Oim0_lAxt9y3Bg-1; Wed, 25 Jun 2025 15:16:58 -0400
X-MC-Unique: OC-ucnk3Oim0_lAxt9y3Bg-1
X-Mimecast-MFC-AGG-ID: OC-ucnk3Oim0_lAxt9y3Bg_1750879017
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4ff581df3so109587f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 12:16:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750879016; x=1751483816;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kw0DlxWGd8ypdEKrTwqtxV3qjtemMX85iv2o6/m6TKA=;
 b=nFCh5TsooPcnauP84BfhQat6GqMC4cU9h/gZiizXu1T8zYalOG5Z6IJkc+0sbnmleo
 taA0aQkIWwFPXtZFpQcPMtbWEUAeh3RY8i9OBjz33CTL0iAgPKLuFhROJErky+sB6mNu
 GZcFEpY5VUP8FRy7lXxHS6UJvX4AM0sZGHtuUSv6IYI9nQ651eAHuNQiOhMHPpc5X6WC
 6ubybhK8ZcD5ty67+c38Zeu/We8Nu/vUGv3mOaueguFomOqFvf5dRZYpvg3eiE7qPTEk
 f92bq+aTONNk9z9UHfdYVlxyNFzsfDrDGRFKL+Teud2aNX0DOs5PmWOVsBksBLmHXR8c
 mFwQ==
X-Gm-Message-State: AOJu0YzOBVJBJMuMtXOAZasK5FT7VGGVD87ozeyPtu9W1irR3U8kCoeQ
 ZJ5RqibNXJuFBgHw4t2wlXCBAFBVjqIILFBswqrRniBbM1KY22v3ZRndkar9e/MSzpppXwUSVQB
 io3Cr50Iz9P2UYFPEcteT3gHXouSjhi7TWKQ+7cDoN/74lFWfyZ9+TmqW
X-Gm-Gg: ASbGncuPqJ+fPJc/McQ7v8/+xAbT7Wd69D5CBUtyEZEd3r9EKBWEV5WEwxkqQzXP46R
 QA84VVzbKDyQp/846K0O/C2UMR7DPQowmLpua6h6ppVLnKWXYdRSNsRoOakDz86MA/fWvAB45Iq
 qfO2imwCFjP02ps5TtKUA+4WuYfcjBhAWNFCRma2sBnuf7OlIN+O4RadWqCg4ObBuZJPo5s/q73
 QP5QIp73w1gP45DmGORTEn81EmN+x+wx4+l0zFn3GHVtNF+IHt0asKZV0TE2Q/VJ8wXVEnIQvgB
 6fCOKQLzbjkatLXO
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3a6f3153609mr594895f8f.24.1750879016205; 
 Wed, 25 Jun 2025 12:16:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJmlrFATq9ZKXjbJIe/P3gVe3cLOn1Xapn8ChTdC04MYtjp+xWUfWm1YdQKNiSjRnWvcN2Hw==
X-Received: by 2002:adf:9cc9:0:b0:3a5:271e:c684 with SMTP id
 ffacd0b85a97d-3a6f3153609mr594876f8f.24.1750879015731; 
 Wed, 25 Jun 2025 12:16:55 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e8068f63sm5329996f8f.39.2025.06.25.12.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Jun 2025 12:16:55 -0700 (PDT)
Date: Wed, 25 Jun 2025 15:16:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org,
 Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v5 3/3] docs: define policy forbidding use of AI code
 generators
Message-ID: <20250625150941-mutt-send-email-mst@kernel.org>
References: <20250616092241.212898-1-armbru@redhat.com>
 <20250616092241.212898-4-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250616092241.212898-4-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 16, 2025 at 11:22:41AM +0200, Markus Armbruster wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> There has been an explosion of interest in so called AI code
> generators. Thus far though, this is has not been matched by a broadly
> accepted legal interpretation of the licensing implications for code
> generator outputs. While the vendors may claim there is no problem and
> a free choice of license is possible, they have an inherent conflict
> of interest in promoting this interpretation. More broadly there is,
> as yet, no broad consensus on the licensing implications of code
> generators trained on inputs under a wide variety of licenses
> 
> The DCO requires contributors to assert they have the right to
> contribute under the designated project license. Given the lack of
> consensus on the licensing of AI code generator output, it is not
> considered credible to assert compliance with the DCO clause (b) or (c)
> where a patch includes such generated code.
> 
> This patch thus defines a policy that the QEMU project will currently
> not accept contributions where use of AI code generators is either
> known, or suspected.
> 
> These are early days of AI-assisted software development. The legal
> questions will be resolved eventually. The tools will mature, and we
> can expect some to become safely usable in free software projects.
> The policy we set now must be for today, and be open to revision. It's
> best to start strict and safe, then relax.
> 
> Meanwhile requests for exceptions can also be considered on a case by
> case basis.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Sorry about only reacting now, was AFK.

So one usecase that to me seems entirely valid, is refactoring.

For example, change a function prototype, or a structure,
and have an LLM update all callers.

The only part of the patch that is expressive is the
actual change, the rest is a technicality and has IMHO nothing to do with
copyright. LLMs can just do it with no hassle.


Can we soften this to only apply to expressive code?

I feel a lot of cleanups would be enabled by this.


> ---
>  docs/devel/code-provenance.rst | 55 +++++++++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
> index c25afed98d..b5aae2e253 100644
> --- a/docs/devel/code-provenance.rst
> +++ b/docs/devel/code-provenance.rst
> @@ -282,4 +282,57 @@ boilerplate code template which is then filled in to produce the final patch.
>  The output of such a tool would still be considered the "preferred format",
>  since it is intended to be a foundation for further human authored changes.
>  Such tools are acceptable to use, provided there is clearly defined copyright
> -and licensing for their output.
> +and licensing for their output. Note in particular the caveats applying to AI
> +content generators below.
> +
> +Use of AI content generators
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +TL;DR:
> +
> +  **Current QEMU project policy is to DECLINE any contributions which are
> +  believed to include or derive from AI generated content. This includes
> +  ChatGPT, Claude, Copilot, Llama and similar tools.**
> +
> +The increasing prevalence of AI-assisted software development results in a
> +number of difficult legal questions and risks for software projects, including
> +QEMU.  Of particular concern is content generated by `Large Language Models
> +<https://en.wikipedia.org/wiki/Large_language_model>`__ (LLMs).
> +
> +The QEMU community requires that contributors certify their patch submissions
> +are made in accordance with the rules of the `Developer's Certificate of
> +Origin (DCO) <dco>`.
> +
> +To satisfy the DCO, the patch contributor has to fully understand the
> +copyright and license status of content they are contributing to QEMU. With AI
> +content generators, the copyright and license status of the output is
> +ill-defined with no generally accepted, settled legal foundation.
> +
> +Where the training material is known, it is common for it to include large
> +volumes of material under restrictive licensing/copyright terms. Even where
> +the training material is all known to be under open source licenses, it is
> +likely to be under a variety of terms, not all of which will be compatible
> +with QEMU's licensing requirements.
> +
> +How contributors could comply with DCO terms (b) or (c) for the output of AI
> +content generators commonly available today is unclear.  The QEMU project is
> +not willing or able to accept the legal risks of non-compliance.
> +
> +The QEMU project thus requires that contributors refrain from using AI content
> +generators on patches intended to be submitted to the project, and will
> +decline any contribution if use of AI is either known or suspected.
> +
> +This policy does not apply to other uses of AI, such as researching APIs or
> +algorithms, static analysis, or debugging, provided their output is not to be
> +included in contributions.
> +
> +Examples of tools impacted by this policy includes GitHub's CoPilot, OpenAI's
> +ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
> +generation agents which are built on top of such tools.
> +
> +This policy may evolve as AI tools mature and the legal situation is
> +clarifed. In the meanwhile, requests for exceptions to this policy will be
> +evaluated by the QEMU project on a case by case basis. To be granted an
> +exception, a contributor will need to demonstrate clarity of the license and
> +copyright status for the tool's output in relation to its training model and
> +code, to the satisfaction of the project maintainers.
> -- 
> 2.49.0


