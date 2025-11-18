Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A3FCED26B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:01:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIWh-00015K-QB; Tue, 18 Nov 2025 05:01:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIWg-00014K-Ei
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:01:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLIWZ-0004yk-FS
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:01:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763460082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dv51Lyer887hsbV5pUHgEl0O/+JkXw4nkkS5QVLat1M=;
 b=AnqbwO/9GqOkMe7SXKMOJhbsGucxnfb3I6MQH9fVerCAcDcG+To1SpC7Nlpcxb7Te7EgcR
 WVtVivJLwck48O0Ga//bzmsxShlpQqsLYq89VtmQDLg0283nNvd6xy1KTz0h4Qns1x/HR2
 7rqEeILLqHAzvfvhYUI556+iKIenhps=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-A-nAYG-BOv6CXpZzXnj0UQ-1; Tue, 18 Nov 2025 05:01:20 -0500
X-MC-Unique: A-nAYG-BOv6CXpZzXnj0UQ-1
X-Mimecast-MFC-AGG-ID: A-nAYG-BOv6CXpZzXnj0UQ_1763460079
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so3010749f8f.2
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763460079; x=1764064879; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Dv51Lyer887hsbV5pUHgEl0O/+JkXw4nkkS5QVLat1M=;
 b=D9KqG4xPdtXodeNQynH0o/YXVBW78+/ZJ6j4z6tnTfjZs0BAb0NDTtkuirTmnY0zcq
 Tl2lOqiBulErDzCC2CQebfXxLfIFHR4pgXxombFNuQzul1NsRl8f0/MPXFUAJzf/Uktr
 ld7vAoXtdNgwX7+jWMPAcIPJ7nXOiMo1sWiFypFe9JjPbWdeIbW5b9reEMlgDlVjLh2L
 F0k1kfEC4CogfBAE2J/OCgtgq0CjaV8DtDLJNEyVIT4IJN9UPyulB8oMub/kMc01U1XY
 QZ1dU3/vadpr10dFq76a/EHN6x4X/yryDnyjRFYDl4RYg9C7i8nH3hmcWz1UYamT7LFZ
 BSzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763460079; x=1764064879;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dv51Lyer887hsbV5pUHgEl0O/+JkXw4nkkS5QVLat1M=;
 b=Z4C1h3YYXG9ZxlfOO02FrUhVHIP2/rsKUj8sJ+SsuMfTddKZXMd9lHqI+gN3XnalgO
 KcIuZaltRbLuCEriY4iNSYUnQzxfn4sb1uezE+GHcMTxMCgF5FhsQeGMCdotPlvbApIH
 9HcDsQZSRmxFZfBCgwhLxAiJC+0nfQ5TRvAtj28Bf7+rWB+ztz966kCaf90PlFlC0lqa
 7H1lhsX5+E2Elez5YUiwCS84Rs7HQ7P34gKioHLdiCMz3RSGCY50yxW+o0Fk0qCWsOKo
 FKFd9lEUR1jKKG5LbqmVczvUIe07loJV34fHqew6VC2+1BPk23Xlf1+ahesovq19dxDs
 iOJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMeRGfaMU8WcT2aKV9o2l2wsoGvKF1mHxRWEGG05PxJ3kJllkYp7M6RirkKX9H+0NmN+9+u2G76P68@nongnu.org
X-Gm-Message-State: AOJu0YzogQ99u3E+GA7WmtS3GjunKnzyP0a0GzByl+yGNVOpqKRB7iuS
 bfC+waAar+fq6sZdhwHm62S2gsWpaTR8Yn1BDu2PLaqLRcCl3OtwC/a+25xHKGdjmpeLGHKHEcI
 syrnWyguT6h8qI6owwmBdmJJxF8TbhD4OTGKu4clTS8QchiCiEQ/2V957
X-Gm-Gg: ASbGncv/2fEb5AfHzCNwNJIyAhOdZ5m4fTxOT5x55MpZOJ8JkFmz3TS804rJzCuX0Ws
 t4Z/YiKxGbDl5giQodsjp6e7vZAn7S+hH+y7WtObFNm4GcSdwLWKApJIsDULZh+uCr4+K6ouHMz
 vedzSrsYsEL26Lj9oSBQCqKa1LyTXWbwri3sGjWQWyfYvkQRxfS6DgxE4r+CrJNEzoP6rqXD1RN
 lAfJoJcTVFt7rhyDJC9F65o1AjRsj2FSV86bt+F8Y6He+lP/LHFG9AOfEJEcwStKG9NFekvHjXl
 Tw1yJgwZMOmMco2B1jXWMzVHRR0aLds05CSodRmsA3w+1wLxqxvKvD1qbJtjb7/n0uGX930m9IY
 LBhZMjq0=
X-Received: by 2002:a5d:5d0d:0:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42b593988eamr14457098f8f.58.1763460079190; 
 Tue, 18 Nov 2025 02:01:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1vI940JlxYKEaUuP72zN3cqYLGbAy5+Fe7T7QjSiM6AYZNY2NY4Bw6HJXCfQ6TLqsSG3O+w==
X-Received: by 2002:a5d:5d0d:0:b0:42b:4185:e590 with SMTP id
 ffacd0b85a97d-42b593988eamr14457057f8f.58.1763460078743; 
 Tue, 18 Nov 2025 02:01:18 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e846afsm30674980f8f.13.2025.11.18.02.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Nov 2025 02:01:18 -0800 (PST)
Message-ID: <04f291fb-4e6f-4fe5-896a-ef7ae7229189@redhat.com>
Date: Tue, 18 Nov 2025 11:01:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] python/mkvenv: add "checktests" dependency group
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-8-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-8-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> This group is intended for packages required to run "make check"
> successfully. Once qemu.qmp is fully divorced from the source tree, this
> will primarily mean the qemu.qmp package and the remaining in-tree
> python packages. It specifically excludes packages only needed to run
> the functional tests, which are not invoked by default for "make check".
> 
> Amend the "check-venv" target to install both dependency groups, to
> avoid a duplicate dependency between them.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   pythondeps.toml        | 4 +++-
>   tests/Makefile.include | 2 +-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/pythondeps.toml b/pythondeps.toml
> index d814bb54d08..b931d8bb578 100644
> --- a/pythondeps.toml
> +++ b/pythondeps.toml
> @@ -31,6 +31,8 @@ meson = { accepted = ">=1.9.0", installed = "1.9.0", canary = "meson" }
>   sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
>   sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>   
> -[functests]
> +[checktests]
>   "qemu.qmp" = { accepted = ">=0.0.5", installed = "0.0.5" }
> +
> +[functests]
>   pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 6f86eb283d3..40b114bd158 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -98,7 +98,7 @@ quiet-venv-pip = $(quiet-@)$(call quiet-command-run, \
>   
>   $(TESTS_VENV_TOKEN): $(SRC_PATH)/pythondeps.toml
>   	$(call quiet-venv-pip,install -e "$(SRC_PATH)/python/")
> -	$(MKVENV_ENSUREGROUP) $< functests
> +	$(MKVENV_ENSUREGROUP) $< checktests functests
>   	$(call quiet-command, touch $@)
>   
>   check-venv: $(TESTS_VENV_TOKEN)

Reviewed-by: Thomas Huth <thuth@redhat.com>


