Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31713C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 17:21:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7emD-0001rR-Pq; Thu, 16 May 2024 13:20:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7emC-0001pH-7Q
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:20:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1s7emA-0000HA-6a
 for qemu-devel@nongnu.org; Thu, 16 May 2024 13:20:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715880017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4joLIfCdfnBX1uf0OTG9nIXXipl/Se23wJVwBrd430M=;
 b=S3TkFFa1Yv9t7qalPwFiTSzTJ1Alc/+6EGlnKBEHrXBLGTRxzuZOUScvyYFK6gYm6M1WRk
 tzBfz4064eFvkCNAbxHSTN701kTm3nt1nNauqdzwQtQDLma4FIuHSMQN4wRCbiv1jSxE69
 dxZbrX2esEg0VfsPjSbIxD4ENXX1gKQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-Xv6uc_MqP4i5GThuLRljfg-1; Thu, 16 May 2024 13:20:15 -0400
X-MC-Unique: Xv6uc_MqP4i5GThuLRljfg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-351d77e63fdso564530f8f.3
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 10:20:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715880014; x=1716484814;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4joLIfCdfnBX1uf0OTG9nIXXipl/Se23wJVwBrd430M=;
 b=kpftdHEeFRkghgzzINPW600YB8WH+K8Cfue93mD6Naw6Lk6B9CWFlMSRXKy9VGUkMt
 gF/vdXztoo1sQkc+Cty+hpbA+Y2cKxhaye+yyl6HSzXBYASVaxowXRp3EJCHA/EYzGhP
 rRCdPoSvPiOXkjcdeHpBxmG5o1BtrAa9znQNJZJWSklMF+/1AbHfKzleqWRvl4uAHWDS
 6ahyLNzp/+Ax2fU5FW2QsRXcRB5c2Oy3eYBUyhHLyXeAe4pIq/fHNSXZb60z47AFqSKg
 sYhG+7fYekQ4pjcn0dSvroNCWsfmiMIHZ7qybwKSI0+gLWxucTbaTfNlZfAFe/nPzPWD
 4umw==
X-Gm-Message-State: AOJu0YxKrarEcFjd3v0nx0R48Myw4zYZUvSaEjNAbr+IDShdguwc+eYR
 /Xw6f3cEsPrhkR4DrX+vcB6zx8BYZZV/Ckq3oYlxasakfw8ZuDtSuXX3oee7VOafkdpMq4OBxsf
 9AyN+wzUjAwmLiPG90dhQ3dLImMiqaa4O9ntRvhNDSYeipioURUecZRogE8ws
X-Received: by 2002:a05:6000:18cc:b0:351:c934:e9d0 with SMTP id
 ffacd0b85a97d-351c934ea1amr7210235f8f.58.1715880014097; 
 Thu, 16 May 2024 10:20:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF54e2Ppm7L2JMxFlQmuy0CHfJWwyZgnj9B/CO8hw9Iq3gN53fgcTxhmU1K3XPTac/BlUSwOQ==
X-Received: by 2002:a05:6000:18cc:b0:351:c934:e9d0 with SMTP id
 ffacd0b85a97d-351c934ea1amr7210209f8f.58.1715880013565; 
 Thu, 16 May 2024 10:20:13 -0700 (PDT)
Received: from redhat.com ([2.52.2.122]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502baacfd3sm19646556f8f.84.2024.05.16.10.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 10:20:13 -0700 (PDT)
Date: Thu, 16 May 2024 13:20:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 0/3] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20240516131141-mutt-send-email-mst@kernel.org>
References: <20240516162230.937047-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240516162230.937047-1-berrange@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 16, 2024 at 05:22:27PM +0100, Daniel P. Berrangé wrote:
> This patch kicks the hornet's nest of AI / LLM code generators.
> 
> With the increasing interest in code generators in recent times,
> it is inevitable that QEMU contributions will include AI generated
> code. Thus far we have remained silent on the matter. Given that
> everyone knows these tools exist, our current position has to be
> considered tacit acceptance of the use of AI generated code in QEMU.
> 
> The question for the project is whether that is a good position for
> QEMU to take or not ?
> 
> IANAL, but I like to think I'm reasonably proficient at understanding
> open source licensing. I am not inherantly against the use of AI tools,
> rather I am anti-risk. I also want to see OSS licenses respected and
> complied with.
> 
> AFAICT at its current state of (im)maturity the question of licensing
> of AI code generator output does not have a broadly accepted / settled
> legal position. This is an inherant bias/self-interest from the vendors
> promoting their usage, who tend to minimize/dismiss the legal questions.
> >From my POV, this puts such tools in a position of elevated legal risk.
> 
> Given the fuzziness over the legal position of generated code from
> such tools, I don't consider it credible (today) for a contributor
> to assert compliance with the DCO terms (b) or (c) (which is a stated
> pre-requisite for QEMU accepting patches) when a patch includes (or is
> derived from) AI generated code.
> 
> By implication, I think that QEMU must (for now) explicitly decline
> to (knowingly) accept AI generated code.
> 
> Perhaps a few years down the line the legal uncertainty will have
> reduced and we can re-evaluate this policy.
> 
> Discuss...

At this junction, the code generated by these tools is of such
quality that I really won't expect it to pass even cursory code
review.


So for now, I propose adding a single paragraph:

 If you wrote the patch, make sure your "From:" and "Signed-off-by:"
 lines use the same spelling. It's okay if you subscribe or contribute to
 the list via more than one address, but using multiple addresses in one
 commit just confuses things. If someone else wrote the patch, git will
 include a "From:" line in the body of the email (different from your
 envelope From:) that will give credit to the correct author; but again,
 that author's Signed-off-by: line is mandatory, with the same spelling.

+Q: I prompted ChatGPT/Copilot/Llama and it wrote
+   the patch for me. Can I submit it and how do I sign it?
+A: Your patch is likely trash or trivial. Please write your own code.






> Changes in v2:
> 
>  * Fix a huge number of typos in docs
>  * Clarify that maintainers should still add R-b where relevant, even
>    if they are already adding their own S-oB.
>  * Clarify situation when contributor re-starts previously abandoned
>    work from another contributor.
>  * Add info about Suggested-by tag
>  * Add new docs section dealing with the broad topic of "generated
>    files" (whether code generators or compilers)
>  * Simplify the section related to prohibition of AI generated files
>    and give further examples of tools considered covered
>  * Remove repeated references to "LLM" as a specific technology, just
>    use the broad "AI" term, except for one use of LLM as an example.
>  * Add note that the policy may evolve if the legal clarity improves
>  * Add note that exceptions can be requested on case-by-case basis
>    if contributor thinks they can demonstrate a credible copyright
>    and licensing status
> 
> Daniel P. Berrangé (3):
>   docs: introduce dedicated page about code provenance / sign-off
>   docs: define policy limiting the inclusion of generated files
>   docs: define policy forbidding use of AI code generators
> 
>  docs/devel/code-provenance.rst    | 315 ++++++++++++++++++++++++++++++
>  docs/devel/index-process.rst      |   1 +
>  docs/devel/submitting-a-patch.rst |  19 +-
>  3 files changed, 318 insertions(+), 17 deletions(-)
>  create mode 100644 docs/devel/code-provenance.rst
> 
> -- 
> 2.43.0


