Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C7D2E03E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 08:32:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRREZ-0005hm-Vi; Fri, 05 Dec 2025 03:32:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRREY-0005g3-3Y
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRREV-0004Xu-LT
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 03:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764923527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=HFChUiYHdQ5ky7unqK4vb0EzR3pAEtgWmdwRsSk39VU=;
 b=EVCEdfcQe/JYFcpEiuuTUsqHSJtnaCOuplGv1FmAjwoxTEIOncnvqp4rLwGRTqF8hZvSYL
 phYyzARiKoaPYR76wQQVErJptkOTZc/leArOol5pMS/NsolHf823WdTxHY0+ehfPKI/tVf
 oTQq9PywS8kFm6OSdol8deUFVRnHpvw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-QGvw8m63NLmkP1BkgXQ-DQ-1; Fri, 05 Dec 2025 03:32:05 -0500
X-MC-Unique: QGvw8m63NLmkP1BkgXQ-DQ-1
X-Mimecast-MFC-AGG-ID: QGvw8m63NLmkP1BkgXQ-DQ_1764923524
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b570776a3so916126f8f.3
 for <qemu-devel@nongnu.org>; Fri, 05 Dec 2025 00:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764923524; x=1765528324; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HFChUiYHdQ5ky7unqK4vb0EzR3pAEtgWmdwRsSk39VU=;
 b=lmqUVFf4WgZ3E4Cs0zep0N+s49bjRjCNRiY4sHw44zXolpG0Udf5+BKpBZiW4DxX9a
 EIJPXpXrMqE/B1YLTm4EMTEPMXoc8XftuafgBEtojkpuE0O8OkEFE+Hk326lddKs6/D6
 Auw4rR1R79pvHt2npbLNLHgAwkKMmMz53XFCGVo1k+MfQQU9xN3nn2ZBbZRXSdUbwf06
 YoLmZIEHSO/KFB/DdQIaO3XaXNXafSuLdyxkk/YDOhzNukoKBm0tKP8pItzOqtElxZ27
 xr2tWBLNcQZzr9NLHZVjYWF6n+UHDj+dQJarSpM9MlVz4hAr37zKTsQ+/GjzTet2+RO0
 cQQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764923524; x=1765528324;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFChUiYHdQ5ky7unqK4vb0EzR3pAEtgWmdwRsSk39VU=;
 b=M9Bf62c8tiNGitpWscOx6WFacQoye9dsijc2nE7j8q+oLehYG/FDTQ3d0d8qrYXKRf
 2aHGl9wYiWtUK1snQkH5FMtA+mADsaMA95ClW2WcqxoqQEbhF61iv5sXc4XFJU828LkL
 tv+uXGgAgPRSvm5SV07+MMnMD/lfcp+rdwVpxENJdxAauB0fhDRu52GD2LmeoiUrc+cY
 ws3iPP/T/kSjjPdjyTVKqMfyTIvy1Wr2VD80CQvAxJ/f/Q1VUGOQmdNTEMGxAUy9CZxo
 zJ3FMXrcsPu5KFz+NjUEwL3xkCD23YQWChNvQSX03GUQ6/2toZbAIgwfv0TvWTFvMLqL
 Ht1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8vhDIEocGIprUQIx7awawVoN9l0bUquzYxtFZMki315dPPpDMIjz/ho1vhiHannFOEn7clbkj0HIZ@nongnu.org
X-Gm-Message-State: AOJu0Yzzd+s87q/XrScEhC2R0bzOXOeclp1YxusW45VOgwlSQH2gBfss
 bcM9kOh2h55RlMkACHSveDxbsDvfWYKLiYYFTlMkYqgVUvpdwYPIvtqZiewGIfV4yJpVhWQr/pJ
 sAIDLsFgOz/Y+ZqIpuBq+hEyii4ZU9fnrgyKHz10E07Esv5+Nvz1+JoPj
X-Gm-Gg: ASbGncv7zmcum8M35N5FoZl/A6/Uzzv/rDou46eGoVo1lUeqq6CgdJ+EeIF1l8V2FDZ
 V6Lj/oOTfD2DdmG28cBCpxhwumk8synmafUWlXi0X757OkkFQqskIcCPzxlS+kGpd30EzUCP5qF
 xSMh7LfOu+Pg4a15E8TUAPlhLPujbUsufZbjFuQPc/LLO/v3S1rIdEA3o0BXGLk6fQ7Dyif2AtN
 eeAcgPpfd5QQK2x35YcP42Zz6pOh+B3xwBwMFU0GKZbNTq1R/wXa5AXipAUJ8ZzV0Hir6XminTz
 EvKthOs2VJEjRNt+Rg38RBLg/sEHxF606Is6fdDdbzMYQx7OmY1c/VfOC4lkkj3B807blpSsiy2
 0N9tHeS4=
X-Received: by 2002:a05:6000:40cc:b0:42b:3dfb:646b with SMTP id
 ffacd0b85a97d-42f731d18e4mr9139682f8f.57.1764923523872; 
 Fri, 05 Dec 2025 00:32:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJdQbF8Hv21A5XMQJ0nAiWpGuUma63Ulr6QyJ7GaqqWurC/1B42ey1QDZ6d33LMze8jmfmRg==
X-Received: by 2002:a05:6000:40cc:b0:42b:3dfb:646b with SMTP id
 ffacd0b85a97d-42f731d18e4mr9139659f8f.57.1764923523474; 
 Fri, 05 Dec 2025 00:32:03 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbe9065sm7583895f8f.8.2025.12.05.00.32.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Dec 2025 00:32:03 -0800 (PST)
Message-ID: <facd55e5-f194-4027-950e-08364f7c1912@redhat.com>
Date: Fri, 5 Dec 2025 09:32:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/15] python/mkvenv: create timestamp file for each
 group "ensured"
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251205060058.1503170-1-jsnow@redhat.com>
 <20251205060058.1503170-2-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251205060058.1503170-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 05/12/2025 07.00, John Snow wrote:
> Each group ensured by the mkvenv script will create an empty timestamp
> file named {groupname}.group which can be used to conditionally trigger
> dependency installation from various scripts and build machinery.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/mkvenv.py | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
> index a064709e6ce..a22e3ee3394 100644
> --- a/python/scripts/mkvenv.py
> +++ b/python/scripts/mkvenv.py
> @@ -838,6 +838,12 @@ def ensure_group(
>               raise Ouch(result[0])
>           raise SystemExit(f"\n{result[0]}\n\n")
>   
> +    if inside_a_venv():
> +        for group in groups:
> +            path = Path(sys.prefix).joinpath(f"{group}.group")
> +            with open(path, "w", encoding="UTF8"):
> +                pass
> +
>   
>   def post_venv_setup() -> None:
>       """

Reviewed-by: Thomas Huth <thuth@redhat.com>


