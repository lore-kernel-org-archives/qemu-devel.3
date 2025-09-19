Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3EEACAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:01:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZn4-00057R-9F; Fri, 19 Sep 2025 08:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzZmt-00054l-Qw
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzZmm-0003Qf-Bd
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Rf+J5SM14RRyXfWe8ZHy9mqCxWv9fVEGlfAIWlWU6Ts=;
 b=QG6/Lrr3I2kShyHQPnL+Ug/AeQbkdvhHpdooGLwimfn7uuUDXRN72+oIm/huhchgCdNiek
 ldT+ItIWbaKiQNWJ7tmt7AQ+WGGp/CpTyKviuDTfNFdY3YD29dm6zS7o2flD65Ods7V7jF
 uXUq2C4DEkygkij0ELO5QZ+NSNwgnJY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-PQVy4JZTPEuPu5QWhoQ-Pw-1; Fri, 19 Sep 2025 08:00:13 -0400
X-MC-Unique: PQVy4JZTPEuPu5QWhoQ-Pw-1
X-Mimecast-MFC-AGG-ID: PQVy4JZTPEuPu5QWhoQ-Pw_1758283213
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ecdc9dbc5fso1302666f8f.1
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 05:00:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758283212; x=1758888012;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Rf+J5SM14RRyXfWe8ZHy9mqCxWv9fVEGlfAIWlWU6Ts=;
 b=nrW+8eAag/WWrMb212a7uVOtS/+qpCp/EppxAnGtyFLODJtIc/eeatI0lJohNwx+8I
 iSEh7bU2Djo4nsxaM+MV37/nIXuac26+BpIrqaGU+9Jkafg33rURasKGtnnITXv4xqKM
 tOwkt9cilHJ4Xnb+r3ZtcyHEMzVwEawhaqMS22wbabc+oyfuDBAh9Z0X2LgzaX4AoNQM
 HSB8/0kszbdWi05YI01usiJZwfqknLQ6X9rRdZHsib4aq7b1QrY2F06grQtuQy0YiLkd
 XGtDtBbiHthgzsd0V7sJCBXYO8ACos6xPysYGKfrAl5aAv5wRTKClEtR98EVDc2x18wZ
 Go2A==
X-Gm-Message-State: AOJu0Yxsg4KSViHghNmmS1MHzCpFHrpb5Yap9/ehVpMeobA1osafKoLo
 18ClJIG/iOLyCfrZJdfq4VnuwiRTnxzLL0Rs6xiMkQUIBqOI7j7r4P9csLeDy55XAzHphUBNeON
 3eDS8TuKFiDRl155zUoUjd7/mriCtH+Afb9OeEZHRl7Dv4SQ8zDnQwVEq
X-Gm-Gg: ASbGncuY+uxIFfQ2wnTolGMbLeCS3q/O6J2STREqKuOLgdGj6soKQBu9iHtuNuCgQbX
 tdmc0h7QN75OOhQF+cLyIenIDnG/hJrHgE/lxi1L3chmX8DsGFzCGDsU4B1jLQHfCYtyHhrLg5a
 AtVMgdfBUF4pIl92p/KkMch00/pJ1xCqIameqZIYaoWQI/YMRK56E8lfn06ZXmgjSKs+IPDmr/g
 tnFYAJNqIWwPtKGcnJyQpFuXPLp6PpTFiP46R6K3WQI3EejiWwwPtF58XcH7QQSlEcWY86++itF
 DvJ08BiJGMNo1XCY+9OPrQMeR7EHe8nqa9dbswh9pwOBeSoN51/Tg2YBPPZiGM13Os/9fv2KgoZ
 JNgsEGQ==
X-Received: by 2002:a5d:5d88:0:b0:3d9:70cc:6dd0 with SMTP id
 ffacd0b85a97d-3ee84afd2fdmr2291371f8f.33.1758283212106; 
 Fri, 19 Sep 2025 05:00:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEn4mUuMy1MZgFy3dbPbGykt63c/gPWX1bvwhzttiBA0Dw+fRfKajmv+MicEvHTzYCjhzH3Uw==
X-Received: by 2002:a5d:5d88:0:b0:3d9:70cc:6dd0 with SMTP id
 ffacd0b85a97d-3ee84afd2fdmr2291328f8f.33.1758283211568; 
 Fri, 19 Sep 2025 05:00:11 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3f1549285c9sm965727f8f.52.2025.09.19.05.00.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 05:00:11 -0700 (PDT)
Message-ID: <137b1cb6-f264-4690-b17d-f41b367fcf0f@redhat.com>
Date: Fri, 19 Sep 2025 14:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 18/19] tests/functional: add
 skipUnlessPasswordlessSudo() decorator
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, eblake@redhat.com,
 michael.roth@amd.com, armbru@redhat.com, farosas@suse.de, peterx@redhat.com,
 berrange@redhat.com, jasowang@redhat.com, steven.sistare@oracle.com,
 leiyang@redhat.com, davydov-max@yandex-team.ru, yc-core@yandex-team.ru
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
 <20250919095545.1912042-19-vsementsov@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250919095545.1912042-19-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 19/09/2025 11.55, Vladimir Sementsov-Ogievskiy wrote:
> To be used in the next commit: that would be a test for TAP
> networking, and it will need to setup TAP device.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/decorators.py | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/tests/functional/qemu_test/decorators.py b/tests/functional/qemu_test/decorators.py
> index c0d1567b14..4b332804ef 100644
> --- a/tests/functional/qemu_test/decorators.py
> +++ b/tests/functional/qemu_test/decorators.py
> @@ -6,6 +6,7 @@
>   import os
>   import platform
>   import resource
> +import subprocess
>   from unittest import skipIf, skipUnless
>   
>   from .cmd import which
> @@ -149,3 +150,18 @@ def skipLockedMemoryTest(locked_memory):
>           ulimit_memory == resource.RLIM_INFINITY or ulimit_memory >= locked_memory * 1024,
>           f'Test required {locked_memory} kB of available locked memory',
>       )
> +
> +'''
> +Decorator to skip execution of a test if passwordless
> +sudo command is not available.
> +'''
> +def skipUnlessPasswordlessSudo():
> +    proc = subprocess.run(["sudo", "-n", "/bin/true"],
> +                          stdin=subprocess.PIPE,
> +                          stdout=subprocess.PIPE,
> +                          stderr=subprocess.STDOUT,
> +                          universal_newlines=True,
> +                          check=False)
> +
> +    return skipUnless(proc.returncode == 0,
> +                      f'requires password-less sudo access: {proc.stdout}')

I'd maybe rather just call it "skipWithoutSudo" ... but anyway:

Reviewed-by: Thomas Huth <thuth@redhat.com>


