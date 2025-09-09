Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755B9CAC587
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 10:17:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvvOs-0007Qy-HO; Tue, 09 Sep 2025 06:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvvOp-0007QL-Tm
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uvvOm-0005vL-2J
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 06:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757412985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2pg0PBVbwHlHd4A386E8sE9ZX+RW3W2BGzZ2LeOjgsk=;
 b=E6kDzSdSyRfkFn930C/iiLBLVeMc2zN4XOkbHQnVHYgKz97S+0Z19v+8yqR0N95MkYTt3I
 rIDja++ldjV37WQdp357TuN/dXsguc2/C2tkvBAyQJQPNZa/h4aWvn+zW/bhqyHwmAhsIU
 sq0jB0gSH3QBZIGSyrjQwuZok4DPJ/Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-kBG94bPyMBy_nKM2tAV_sg-1; Tue, 09 Sep 2025 06:16:23 -0400
X-MC-Unique: kBG94bPyMBy_nKM2tAV_sg-1
X-Mimecast-MFC-AGG-ID: kBG94bPyMBy_nKM2tAV_sg_1757412983
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de27bf706so11408175e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 03:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757412982; x=1758017782;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2pg0PBVbwHlHd4A386E8sE9ZX+RW3W2BGzZ2LeOjgsk=;
 b=olEezNMBlHgoxYvRFonxmA0tYjY/AkEAjDmQCkvkjXmbjrzDEy76WgtaCr7MvzqSoR
 Fsfnuv+yRudp/tsV89bWeBrUaAtZ7n8r6JvdlrHI6l5voEl05+x/LRhzJB1IhJdyYl3s
 roiU9+F8Qggi1+YibMwdXtaqVm9NgtSOur94Ih88EdyrluL9QzEeBpHxz7IfBJNWA9Sl
 tohFCh+310MbcK3Ns8qtsnLFO8fWcGrc0iGOVmRE7/itA7jAKFUwE9PYH189MJaswg4g
 I2dUOcQaDgTBTu3ZBTGV9s6Whqg18XcH4tS/MhMz6l42X0Ymt9ZozdHc9b1PuUDHLpR0
 fz0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUbbocO7qHXt7CoVv+c6XX5/2fWmocCPSTJP8hDW05tKSuMhR+4v3z/kJlw+8uRjgnc4Lqp/gNwBmQG@nongnu.org
X-Gm-Message-State: AOJu0YyAjSC6n5NgQdqm65ua+lzlx8ArzxBZX+LkRtc7G17G0PGrH3YU
 3uYBi7j3QGqu3RYU+cHK3+kzF8jJhySb5vtD+qNgsVa0AaaRqD19ERhe/Xug8wpC71q7TWjaZPZ
 4xWN/CYDOXZJ+Yntmv5LcRlL/t3OmG0pT/iPL4QL8t3/2kmDRnIKSTUAZ
X-Gm-Gg: ASbGncupoWp9zRuaWGQ1eLyXgFRJSN+ZpLvHp9kfNKdj+0odfPZauLWwLfyplaDjqBz
 JPEQDSQFIe39Il/NzNho850xSX04Dz5G+v1Zt8xfo7A+9X/gnHzkMpFPyFEzXdToLL0g63L9p6z
 g5wxlfaN8beOBPvRMIYbXLio+0UeLE+z6U1V/WZbjkOIuN7gDuQajJyprMGY6/wlyP0BZB2ahY9
 NSg6m04UJZEktLNxYfmJP60L1FZ2bWbaTwuSPgGg9FWRGTWrvhFomuKI/bRAuDcHF7X0IF0YtLQ
 wp7Dmw1gl6o5FB0JlUPFsGi8BGTR6uGbQoa3jFDi1zydIqsjq5ojxHGrg1xXhu4kBEYiuc+enzK
 1RKBn1Q==
X-Received: by 2002:a05:600c:1993:b0:45b:7bba:c7a6 with SMTP id
 5b1f17b1804b1-45dddef9cc0mr94145385e9.32.1757412982557; 
 Tue, 09 Sep 2025 03:16:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaVq9ez9FqjBFUiCmyQkfF/k6KYBRv/0jAqvyM8qJB4BJVuBXLhThmdYzEdUWk1brA5arAQg==
X-Received: by 2002:a05:600c:1993:b0:45b:7bba:c7a6 with SMTP id
 5b1f17b1804b1-45dddef9cc0mr94145145e9.32.1757412982121; 
 Tue, 09 Sep 2025 03:16:22 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-183.pools.arcor-ip.net.
 [47.64.113.183]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e8ab14esm522202475e9.21.2025.09.09.03.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Sep 2025 03:16:21 -0700 (PDT)
Message-ID: <95eb8569-2390-4106-8ca0-dca8ab0a557c@redhat.com>
Date: Tue, 9 Sep 2025 12:16:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests/functional: avoid duplicate messages on failures
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250908135722.3375580-1-berrange@redhat.com>
 <20250908135722.3375580-3-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250908135722.3375580-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 08/09/2025 15.57, Daniel P. Berrangé wrote:
> In some scenarios the same tests is mentioned in both the
> 'res.results.errors' and 'res.results.failures' array returned
> by unittest.main(). This was seen when the 'tearDown' method
> raised an exception.
> 
> In such a case, we printed out the same information about where
> to find a log file twice for each test. Track which tests we
> have already reported on, to avoid the duplication.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index fbeb171058..82a7724404 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -251,13 +251,14 @@ def main():
>                                      test_output_log = pycotap.LogMode.LogToError)
>           res = unittest.main(module = None, testRunner = tr, exit = False,
>                               argv=[sys.argv[0], path] + sys.argv[1:])
> +        failed = {}
>           for (test, message) in res.result.errors + res.result.failures:
> -
> -            if hasattr(test, "log_filename"):
> +            if hasattr(test, "log_filename") and not test.id() in failed:
>                   print('More information on ' + test.id() + ' could be found here:'
>                         '\n %s' % test.log_filename, file=sys.stderr)
>                   if hasattr(test, 'console_log_name'):
>                       print(' %s' % test.console_log_name, file=sys.stderr)
> +                failed[test.id()] = True
>           sys.exit(not res.result.wasSuccessful())

Reviewed-by: Thomas Huth <thuth@redhat.com>


