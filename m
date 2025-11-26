Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F9D1038C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 08:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOAhU-0003pF-DY; Wed, 26 Nov 2025 03:16:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOAh8-0003W7-L3
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vOAh6-0001rn-1r
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 03:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764144966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xam+PagldMomz04aC2PIs8ygtgpLSF/DFBMpcQHcj7U=;
 b=brmdpuGQbK05TTaa+YPbZQ3UlAe1cXDZ2H2GLI+o+iPtN1oBMWFezmRYVMaeMINA30yK6S
 firUifAYUtckGS23tIuC5LWPIqZXXqgs67ZAAavPHZNNo9uXno8R9Y7GHj1X+g2vBoHuoO
 ybI4eSzLwzsh7KHAq9JY0xlsPMbynaQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-0k3rPeZvNAq6wT4bCy2UFA-1; Wed, 26 Nov 2025 03:16:04 -0500
X-MC-Unique: 0k3rPeZvNAq6wT4bCy2UFA-1
X-Mimecast-MFC-AGG-ID: 0k3rPeZvNAq6wT4bCy2UFA_1764144963
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b72a8546d73so882887666b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 00:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764144963; x=1764749763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Xam+PagldMomz04aC2PIs8ygtgpLSF/DFBMpcQHcj7U=;
 b=UmVG/alnsLOxDjG4GKQQ1T1x8mfgQcw1XUdXUrXdGVXN6MNxeNhWdZYBTNAhdPKC7m
 pdCgUOtR4FTB550lf/STQO2oPrhsGxFgqOFpAG+jH2dY+HFjtsDgVs33UMInmhK/7ugZ
 lAbmOoevV95XjsGCK9Cetou3DRf3NbqvPzH5LXp+4OHCfH2K/FwSLrdT6n2hhzWVWx3u
 GPqyn+pSG2Bb/+PPyeIMRH8x0cI/Whzd7PugrLVDxcVm29zH/NacAmH6DX1SWbmQppvZ
 P86IyN6AEPXqH4yq3AoZQpnKFd5o0ephz9AY1QllsNfpXK0x/HEqi28i97nhueAqrFy5
 d1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764144963; x=1764749763;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xam+PagldMomz04aC2PIs8ygtgpLSF/DFBMpcQHcj7U=;
 b=q9cu31djRIwGXh38qqI9ZVVgIOoFdt5WSuNqWusyPUl5ZEqGDHJlXlTlMm99pf/mGg
 kArJqK5KRuYG7HF5ckJBlZPc2mixUYsnBtBlQ5vTWTiH8iwthbBisKF+qEOx62UsG0EO
 vLvrLKoS8YF1r/yUtIIsuVNRlduTGSdIErGgY18/wF3wG5nxsW8PyoeyDtiE8Dpy7OyE
 2Ygrnm+/EWFCd9H7R9OUKvYbyEr52FhaBhnpTVtX0taoVNlkD6u+mNJlib7Venmf5+EQ
 5js37Hc1fl5zEx555vFN/li9CaNlfH4zA1B7YgpHow7PK0S1QhCggodmYuFP/QQL9VBq
 KK2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbCmPeYxJxXHvxyJf1JVMYGylej0A2I+aIPzDrrCbOSWL+/uQNOvgeLE2TZFdzkIep9XwcRlLb6w+X@nongnu.org
X-Gm-Message-State: AOJu0Yxjs4eI7d2vyuu2zLnpmKdy/9N7XL4p+kLOObHxgOdY46+2WBnj
 LAOFWSw99YQCFYv/z7WPD3QIoaj1LhELb8uFVolmu9S9Y9nLx5e2e8SNknwW2exQQmb4xoz7G77
 iBWgLtaIRd2CZDp34wmT4vIdRcsT4t3JvgSt/yla8xgI5qy3xA/peeMgU
X-Gm-Gg: ASbGncuNQCsQLsCX2Y5bXyr4GqNOambf88eGUi1ihIPCiVsOMrjtnHTbJVF/sFRAkzw
 PW48Pokzrb7lOVekAYD5xER3watALx97VhOJ39yDUP+JHVFvifaJcBRfy8lTeyutM91msFWrIJ/
 bA2w21CN9XKmN1rCrS5Kh1cL3aXAcO/y63qPLkRi5nPek1VEXTJIEEUY4xMZCCfWf1ybV7L4MST
 vsl8KxlllZ3+AX51HaKL2e05QwyvdncAnS4LVBX9n9xisqUjORHmoKUUNpGAoT6K5VE6qfLFj5+
 gxdYKV5zc5s5sDeewCKoeQvjG7XBJsH6CXgR2/zlRnnHBIBLvFg50JH2XO39sTu9a9fk73oWf2+
 FwztSa5o=
X-Received: by 2002:a17:906:fd84:b0:b76:49ae:6ee6 with SMTP id
 a640c23a62f3a-b7671700506mr2099451766b.15.1764144963037; 
 Wed, 26 Nov 2025 00:16:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6kAeXwBgXdhnO8Y1C4eW0l9qPuMdndbmMzF3fbjDEWWOsx/H02l93yBuwbpF2w6zIQ3/bgA==
X-Received: by 2002:a17:906:fd84:b0:b76:49ae:6ee6 with SMTP id
 a640c23a62f3a-b7671700506mr2099448966b.15.1764144962584; 
 Wed, 26 Nov 2025 00:16:02 -0800 (PST)
Received: from [192.168.0.5] ([47.64.115.162])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b7654d56a70sm1825718866b.22.2025.11.26.00.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Nov 2025 00:16:01 -0800 (PST)
Message-ID: <fada9d5d-a2f7-4ebb-92ed-3f3a8627316f@redhat.com>
Date: Wed, 26 Nov 2025 09:16:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/16] tests: conditionally run "make check-venv"
 during build phase
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Roth <michael.roth@amd.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org
References: <20251125040045.461148-1-jsnow@redhat.com>
 <20251125040045.461148-11-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251125040045.461148-11-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 25/11/2025 05.00, John Snow wrote:
> Some tests need test dependencies, some tests don't. Instead of running
> "make check" manually, use a CI variable for the template that allows us
> to front-load the testing dependencies without needing to incur another
> re-configure command.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index d866cb12bb1..cfa123d3a10 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -32,6 +32,10 @@
>         then
>           pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
>         fi || exit 1;
> +    - if test -n "$SETUP_CHECK_VENV";
> +      then
> +        make check-venv;
> +      fi;
I'm not sure, but I think this is likely not quite working as you intended 
it. The above code hunk is added to native_build_job_template, i.e. it's 
executed for the build-* jobs, but in the next patch, you only set the 
environment variable on the crash-test-* jobs. I don't think that the 
environment variables propagate backward from a later job to an earlier one.

Looking at the output of another build job, e.g. build-system-alpine:

  https://gitlab.com/thuth/qemu/-/jobs/12211712932#L2156

... it looks like pygdbmi is now also always installed there, i.e. something 
else triggers "check-venv" on all build jobs now, and that's why you were 
able to drop the "check-venv" in the crash-test-* jobs in the next patch 
now. No clue what's causing this now, but IMHO it should be fine if we just 
unconditionally do "check-venv" in all build jobs anyway (we also need the 
venv in a bunch of other test jobs anyway), so I'd rather do the "make 
check-venv" in this patch unconditionally here, and drop the next patch that 
sets SETUP_CHECK_VENV in the crash-test jobs. WDYT?

  Thomas


