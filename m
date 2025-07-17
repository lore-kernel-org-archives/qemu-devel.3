Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 200CEC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 20:49:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucVX9-0005CJ-L4; Thu, 17 Jul 2025 16:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ucTf7-0005ux-H4
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:48:58 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1ucTf5-0001pE-5E
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 14:48:57 -0400
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-41eaf97412eso524404b6e.3
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 11:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752778133; x=1753382933; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=l8sB0Wp4dAdhXlR7yni31TjiGwl6R8lw2UlXEubeq3g=;
 b=nFg0l220QLDma515SF9tuj7Zz4oskJICPFu/wE4B/sgln89PRYvKecP7oG4U3TjoYS
 fLMZrvjH58e9wRoNZzOPe2LsDbYDCqOJx1pV3eAc7tl/4p5fLvj3IYyoRhVFSnKCZJv7
 ivula4JYcl97ECqY0PigPOr/y8tJiXRAs+XI8133/wIOiz9WaFp9DcybIAWmcsD12WbQ
 kdg3nVFH0Wyc6azM2jtBwzzfGDezOwW+DcMNGPSPcznmpb4G3H1wnuUC97qk3kyaueMD
 Ns8gBbGQeJc4vSqg6f5ZAHtITBTq6rKVjtS3GGz3G9LyKNXKEePSX5KdQNStjGZjHlRC
 2PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752778133; x=1753382933;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=l8sB0Wp4dAdhXlR7yni31TjiGwl6R8lw2UlXEubeq3g=;
 b=J++JAXv7BRLdpq5BRCDUva5V9Qqh6O5Frp/DfK8ZFQihjWYRgCY4kz2Oh6vyoFceA/
 VWs9aE+i94+tyepynakY8Z+BVqzu235NRXzBga5UysPCl5dPpysXwaSerEmYG7XyKwDr
 H+ebIzlZ3zoVGqTkAyc/TZg1vdB7W44KEWOQIuPOVek3x7Q+gfg3DNYZW8vg3uac8E8F
 DW947h2REtlTqTRrFj5OlaBcHlj/bU1a3VzbiRfX78CVpvotmsZzFIv56rFSE5iv6fFC
 eKYfzf2odDFd1vmbJjS7K/aS+E89uCjekx9kEC88Ht+uW75CjYmAJcLMysu+kzwt67j/
 8DXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBFLa/AEHfZoxjgLRwa9omw8X0VJp05u7I9GLZohkhIgULqnzGKjvbsG/u1zDXfhZgu41Gc1wsvFLh@nongnu.org
X-Gm-Message-State: AOJu0Yz0TPw6IJhPrnHXj+8DKlbesSkyBxxVmIwrDSosXl2kAkZuT21r
 jTTW51e0fyq9ICVt68P4de9ewE9krjQ9Km4T52JQc8HpR86kKeSrVg2hLk2xr0gFetY=
X-Gm-Gg: ASbGncv+XHq23ktwwO+mokF+7LbA/bdz/Ckr5FhJk/W/apUb+PN8vgZIayQHw4LAlX1
 C4Pvj9U4eC2LNaUK7nqaLdmzRZcPw74TmgrikMOchS6n/d+nc3bAoOvNhOI3376eEvGxLMare90
 b8KMvhyHa6C2qdeCXC48WGtQxXOAoq+/7kXutGZEmoSTu+nl6bJzYsM8+FET/tl8rVPxabLVZTm
 BUOnnIqbHpns2OnMsx3bc2c4JCFmHsS/KIQj/3T2nEMDTwDiACmF21pO/WBn02jXFSRd6N91Xu+
 2lAq/ZhGwR3rziBgAP9eOT25VvEuf8/Cg+NFu9AsjtFKFGbPOU8ubFJCqp47zCWTvl/g3XgH3Co
 xgdPChTG5HMdrwmWBaaYJBzsvXlUPNS358UskbVseLXSX9bC+LVLEo9W/cDJ1P/0K
X-Google-Smtp-Source: AGHT+IHH8IBsh7cEGvB+AGwe+RdFt8WXioQIbcn8aB28OQtmF7LyuTaTaXjZz6CUzCvs+1fqh6jEBw==
X-Received: by 2002:a05:6808:3090:b0:40a:bdc5:d744 with SMTP id
 5614622812f47-41d038d85bamr5926349b6e.13.1752778132685; 
 Thu, 17 Jul 2025 11:48:52 -0700 (PDT)
Received: from [192.168.0.102] (189-47-46-41.dsl.telesp.net.br. [189.47.46.41])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-414196c7484sm3642482b6e.15.2025.07.17.11.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Jul 2025 11:48:51 -0700 (PDT)
Message-ID: <a1aee315-0595-4167-be34-5cfff6d7615a@linaro.org>
Date: Thu, 17 Jul 2025 15:49:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/devel/submitting-a-patch.rst: add b4 section
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250717-docs_add_b4_section-v1-1-2dfb4ad2fe07@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250717-docs_add_b4_section-v1-1-2dfb4ad2fe07@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=gustavo.romero@linaro.org; helo=mail-oi1-x244.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Manos,

Nice, I use a lot b4 and I think many QEMU devs use it as well :)

On 7/17/25 10:53, Manos Pitsidianakis wrote:
> Add a section about b4, an actively maintained and widely packaged CLI
> tool for contributing to patch-based development projects.
> 
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> ---
>   docs/devel/submitting-a-patch.rst | 40 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 38 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
> index f7917b899f6892ef74908fe8f1399b6ae5a30324..5160813ca8cf12c0547b88586059487d1e90fe18 100644
> --- a/docs/devel/submitting-a-patch.rst
> +++ b/docs/devel/submitting-a-patch.rst
> @@ -235,6 +235,38 @@ to another list.) ``git send-email`` (`step-by-step setup guide
>   works best for delivering the patch without mangling it, but
>   attachments can be used as a last resort on a first-time submission.
>   
> +.. _use_b4:
> +
> +Use B4
> +~~~~~~
> +
> +The `b4`_ tool, used for Linux kernel development, can also be used for QEMU
> +development. It is packaged in most distros and PyPi. The QEMU source tree
> +includes a ``b4`` project configuration file at the root: ``.b4-config``.
> +
> +Example workflow to prepare a patch series:
> +
> +1. Start with a clean checkout of the ``master`` branch.
> +2. Create a new series with a topical branch name using ``b4 prep -n descriptive-name``.
> +   ``b4`` will create a ``b4/descriptive-name`` branch and switch to it.
> +3. Commit your changes, following this page's guidelines about proper commit messages etc.
> +4. Write a descriptive cover later with ``b4 prep --edit-cover``.

Nit: You meant "cover letter" here maybe?

Otherwise:

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

> +5. Add maintainer and reviewer CCs with ``b4 prep --auto-to-cc``. You can make
> +   changes to Cc: and To: recipients by editing the cover letter.
> +6. Run patch checks with ``b4 prep --check``.
> +7. Optionally review the patches with ``b4 send --dry-run`` which will print the
> +   raw patches in standard output.
> +
> +To send the patches, you can:
> +
> +- Setup ``git-send-email`` and use ``b4 send``, or
> +- Export the patches to files using ``b4 send -o OUTPUT_DIR`` and send them manually.
> +
> +For more details, consult the `b4 documentation`_.
> +
> +.. _b4 documentation: https://b4.docs.kernel.org/
> +.. _b4: https://github.com/mricon/b4/
> +
>   .. _use_git_publish:
>   
>   Use git-publish
> @@ -418,7 +450,7 @@ Retrieve an existing series
>   ---------------------------
>   
>   If you want to apply an existing series on top of your tree, you can simply use
> -`b4 <https://github.com/mricon/b4>`__.
> +`b4`_.
>   
>   ::
>   
> @@ -533,7 +565,11 @@ summary belongs. The `git-publish
>   <https://github.com/stefanha/git-publish>`__ script can help with
>   tracking a good summary across versions. Also, the `git-backport-diff
>   <https://github.com/codyprime/git-scripts>`__ script can help focus
> -reviewers on what changed between revisions.
> +reviewers on what changed between revisions. The ``b4`` tool automatically
> +generates a version history section in the cover letter, including links to the
> +previous versions on `Lore`_.
> +
> +.. _Lore: https://lore.kernel.org/
>   
>   .. _tips_and_tricks:
>   
> 
> ---
> base-commit: f96b157ebb93f94cd56ebbc99bc20982b8fd86ef
> change-id: 20250717-docs_add_b4_section-fc37e538b20b
> 
> --
> γαῖα πυρί μιχθήτω
> 
> 


