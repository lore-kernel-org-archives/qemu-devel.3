Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AC0D0C84F
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcBF-0005lN-9W; Tue, 13 Jan 2026 06:03:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfcBD-0005k7-6w
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:03:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vfcBB-0006yS-Io
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 06:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768302195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NKsr+DZxCj+gQFi27HG+OGbSTE8XvUSXtxhtVbaMLRY=;
 b=HK6NeEfHVQvj/i7dZCjxc7Za+KFBDo1ttbvX/IylvFfpnFJz1Fd60Q+IqbgSHdcMnW3gr8
 PJ3eks7LPspgE7bE/wvBOhm+zcjuNKm5nX+Hj7FVnMZFIcaKTUgUfb+nhu40NKD77NKUp8
 k9XsRI2sgjqa+j2/WqMeYBxdopoNrPg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653--hkiapDvNO-qxQAXlo4mrg-1; Tue, 13 Jan 2026 06:03:14 -0500
X-MC-Unique: -hkiapDvNO-qxQAXlo4mrg-1
X-Mimecast-MFC-AGG-ID: -hkiapDvNO-qxQAXlo4mrg_1768302193
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so45629325e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 03:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768302193; x=1768906993; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NKsr+DZxCj+gQFi27HG+OGbSTE8XvUSXtxhtVbaMLRY=;
 b=VREeOay+TBw6g6Q0mzClvIwrCy+79i2oL0Fmm6OaudR0hr73ggMo7SXxBXH8d6r+GV
 23FOv3hpMzEGoye998Oyzm5hcnJARY0hmXN5p8QYKXH0gBsvWvmk95YSqE1yd4fnFVSK
 7UYZV9bDO0BNH6cayIk0cMmLxEQatQWAuc/5d9GCZUUQxLPa/F3E1W+TZva5ZtNrFMcw
 4O3LQ0foSuKx2yBAWGBrtMb/WX0XUGkan87XFWSM6xvJd65G9Y0B2d8AVljBcCRHbbbV
 bVbTWPPjsD1aJt//7sTHo2ib/hlD9FSVHld6hxKWbiMtTQllt3mx2GFigp0h+hWbQd78
 Dv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768302193; x=1768906993;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKsr+DZxCj+gQFi27HG+OGbSTE8XvUSXtxhtVbaMLRY=;
 b=H4qSHD9m3oGDBGM4CouNRYUePJsnI8hrjnkxAdl1jXFCBzBNzZh9mK8Cs1gctE7W39
 t2TmujQ552KwqXRHzgeEt7fI9GKW1E/hyEWn/NU4rLUVpP2n5se48STQ8C0TiwWI9KHr
 sr1DVzD7de5Aia/FuN9xuM+imxbuCJfglUG2ZDPqXb1qoGVNom55+MjuVQPAszMM2XXc
 Q5tfS89sZt5JZhKpVYMh2INWexj24cwcFv+W/0L7svEoRJ1XkOCXBLsrzhnKBoNYlQkB
 HHnCKv5udg86LqVNB+XZvwEywtemINKXPAEQcbiWi9UyjkY4jpknG1spWCG2HRWx9zcR
 Yp1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdN4PAl7po6AXT2EDJz/uAgcqi+F45gfUzqwjRenlb09NjxKpwjaRUvr5wlDTw0q1k4Bb00d2DCtP/@nongnu.org
X-Gm-Message-State: AOJu0Yx3L28cCUnqg6e3Q3XbGjA198BJVlf4Hr1Q1CmBvZQwBDnnDEbx
 L9Ggr0Vzl3muvLZRrzAbAbjoex5EggnGy3DehypjkEf9ebMUJOMHXnRyuYTAGtoXdIKer4iT+NZ
 jHYhHcom/wImC3wrkqGcWTiMbx7pWHESYqRoTrE+se5lS9m1WO0q6G3fS
X-Gm-Gg: AY/fxX5Tvt1LJkkfKWtQDoZCeeE9nFGOfa5F7SbDXuLijkBmwbWnrDT7w9zBOA5VcpC
 EQdpT5RgBZxSLvGe5vd1Zxpz/BfAXOobfwfjz5COwcm/3wpjs0FY/rxasn7XexK7z11gBOGirN5
 L80lOTqWfm/xQ3A3zLhiJTt8o6zAjzA43qAZILj4VPbq7feDTcrmxzUC18En7zg+0dFfu3VNvNA
 a9MoYycQZlMcL3V/YsEaROW4ZShdDmCwMSb/idRCX79Kg1BJ9LiUwm5dZbTRGY1HyGvNgaqMfkP
 /4X9o5eMCu7FcW6QN+4kKJE4q3m01OVQl9Tg7WChBNfNk5V79M9GvYPNjfqwb8ADEdkjEiIraBb
 jdzQlpgc=
X-Received: by 2002:a05:600c:a04:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d84b3b668mr269340635e9.23.1768302193496; 
 Tue, 13 Jan 2026 03:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHo4keTXC/spmQB/erZJBlSV0QsvFa41KS75hm9U3xCsU0vFD6Q6rHSsv2cYFHvUNeDWmFqnw==
X-Received: by 2002:a05:600c:a04:b0:47d:5dae:73b1 with SMTP id
 5b1f17b1804b1-47d84b3b668mr269340095e9.23.1768302192999; 
 Tue, 13 Jan 2026 03:03:12 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f7035f2sm383268695e9.12.2026.01.13.03.03.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 03:03:12 -0800 (PST)
Message-ID: <237ff4ca-a135-4b82-862f-3c9a8fe4c86e@redhat.com>
Date: Tue, 13 Jan 2026 12:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/13] tests: ensure all qcow2 I/O tests are able to be
 run via make
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
References: <20260112204026.710659-1-berrange@redhat.com>
 <20260112204026.710659-5-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260112204026.710659-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/01/2026 21.40, Daniel P. Berrangé wrote:
> For block formats marked as 'quick', only tests in the 'auto' group are
> added to the meson test suite.
> 
> The result of this is that qcow2 tests not in the 'auto' group cannot be
> run at all, even if passing SPEED=slow or SPEED=thorough.
> 
> To fix this we need todo two passes over the I/O test list. First add
> all tests from 'auto' group into the 'block' suite, so they are run by
> default. Then on the second pass add any tests which were not in 'auto'
> into the 'block-slow' suite, so they get run when SPEED=slow or
> SPEED=thorough.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/qemu-iotests/meson.build | 48 ++++++++++++++++++++++++++++++----
>   1 file changed, 43 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.build
> index bf588cc2c9..1a24d801a3 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -30,16 +30,48 @@ endforeach
>   qemu_iotests_check_cmd = files('check')
>   
>   foreach format, speed: qemu_iotests_formats
> +  # Formats tagged 'quick' get the subset of tests in the 'auto'
> +  # group, run by default with 'make check' / 'make check-block'
> +  seen = []
>     if speed == 'quick'
> -    suites = 'block'
> +    args = ['-tap', '-' + format, '-g', 'auto']
> +    suites = ['block']
> +
> +    rc = run_command(
> +      [python, qemu_iotests_check_cmd] + args + ['-n'],
> +      check: true,
> +    )
> +
> +    foreach item: rc.stdout().strip().split()
> +      seen += item
> +      args = [qemu_iotests_check_cmd,
> +              '-tap', '-' + format, item,
> +              '--source-dir', meson.current_source_dir(),
> +              '--build-dir', meson.current_build_dir()]
> +      # Some individual tests take as long as 45 seconds
> +      # Bump the timeout to 3 minutes for some headroom
> +      # on slow machines to minimize spurious failures
> +      test('io-' + format + '-' + item,
> +           python,
> +           args: args,
> +           depends: qemu_iotests_binaries,
> +           env: qemu_iotests_env,
> +           protocol: 'tap',
> +           timeout: 180,
> +           suite: suites)
> +    endforeach

It's a little bit unfortunate that we have this construct now twice in the 
meson.build file (with just the difference of the "-g auto") ... but I 
currently lack an idea how it could be done in a better way, so:

Reviewed-by: Thomas Huth <thuth@redhat.com>


> +  endif
> +
> +  suites = []
> +  # Any format tagged quick or slow also gets added to slow
> +  # otherwise its tagged thorough
> +  if speed != 'thorough'
> +    suites += ['block-slow']
>     else
> -    suites = ['block-' + speed]
> +    suites += ['block-thorough']
>     endif
>   
>     args = ['-tap', '-' + format]
> -  if speed == 'quick'
> -      args += ['-g', 'auto']
> -  endif
>   
>     rc = run_command(
>         [python, qemu_iotests_check_cmd] + args + ['-n'],
> @@ -47,6 +79,12 @@ foreach format, speed: qemu_iotests_formats
>     )
>   
>     foreach item: rc.stdout().strip().split()
> +      # Skip any tests already added from the 'auto' group
> +      # as they're run in the 'quick' suite already
> +      if item in seen
> +          continue
> +      endif
> +
>         args = [qemu_iotests_check_cmd,
>                 '-tap', '-' + format, item,
>                 '--source-dir', meson.current_source_dir(),


