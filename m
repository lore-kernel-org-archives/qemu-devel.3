Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66230C7EE30
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Jun 2025 09:17:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUMFh-0008Ts-PK; Wed, 25 Jun 2025 05:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUMFF-0008Q7-CI
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uUMF8-0003iF-AS
 for qemu-devel@nongnu.org; Wed, 25 Jun 2025 05:16:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750842990;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIocLogfrgK+l1a8CNugq6b9hdRreoiwycFXhnUjGKc=;
 b=LSXgzezRcClO/9WcXseCLbv84v38axDTe1SFnurHptaVznJYcI+vQvN0YhxeL7ZNzjEOx3
 3IPkDlbVY/xxXvSQKOasVnWuQEKNWpyZ3iVAtP6s/wh0TrN0aFw3VskQjtARcrqN+4H7HG
 6/wPR4bw6q0rj+XR/GMdXo5c+8vERgY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-TZHUmBJMM1usZfor6Cgqvg-1; Wed, 25 Jun 2025 05:16:28 -0400
X-MC-Unique: TZHUmBJMM1usZfor6Cgqvg-1
X-Mimecast-MFC-AGG-ID: TZHUmBJMM1usZfor6Cgqvg_1750842987
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4eee2398bso674464f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Jun 2025 02:16:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750842987; x=1751447787;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QIocLogfrgK+l1a8CNugq6b9hdRreoiwycFXhnUjGKc=;
 b=TOz5GBZUPFQplLwPWGNjodQAz3Gac/EaMff9dy1pV8u7DxTU4SxqTM0rxVyyb4aBX0
 0SIXe+FMIzxZ6I1GnsafUR5LFImcNXMElbqMvgo75y+tttZ+fhUON+Vzc307yqvtKKa+
 dQVyG5pHsuDV2ghPKxFOkRAnpXAEHAutky3mOXZ9H1rXJg1zvTCDPNjkOPOeYqNzmYf6
 8KAR6bk28mFXIx2ms7EqnrhFl+X7WUCWNdojtgGnXAUpZqxLj7oqjFSjLs7QZTJl5xkP
 Mzzu8zmSnsPNIeIMJqATXRRBM56HXGAB10bEyYRV/8pZNjganCpruJb1CVkYMrBhSUq9
 JMjw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJQhrWFLUvJ8Jfo/mylAlC1x3e9KNTfbg+oJEw3Lm0ywHdBkieMzPqId4KI7ULbF/hkDYlnj1Vaqsq@nongnu.org
X-Gm-Message-State: AOJu0Yx5tm3/cNjOUkZwBHeOTJX0Fl8HH1SQAbtACLkk7rwa8g/o/wNk
 nIjxIBkl52i7uu3g6ooBAKxEuKSGxCkGbWnkK7sX/Mu1FVceg1lz/fIw40DkSYepgurGg7IeEkZ
 ElvuUuWGTgVqCHpxIfFOk63hV5bvKheiglSmHMj3OLYuXewPbRlOZ8BS4
X-Gm-Gg: ASbGncui4PbZ3r8Qh9kq71tmYWfUpJ6d7POycvPxfaywUcEEsone/QJyy683vd+arls
 pbWRgWAElw+dKztCUgVlFPswy8wSppWQL+sjVxSoUG5uNOcXNxXKk8bRONNIAERYPALfTQfsDxN
 8lE2mIMLnU980nwEWqTVJsIThtWbv0dYVNQnjvTWgmRE0R/4N2ctwQKF/TkEDUL4HHBAA1zprjd
 /NsTk/TEy4BbWHQBYrE+HDcBJyvzoDxWmkKTpYaHVDO+yQPskTX32nuL45sdGSFcI+NuIY1dzmK
 VqGAp6gpdIK9zRlBwkB5YH3cQpvMQNZfsUkO7mYkQELdcThItQwEFi1wRtFGF7hkM10mHw==
X-Received: by 2002:a05:6000:2b10:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3a6ed660d0emr1189729f8f.46.1750842987094; 
 Wed, 25 Jun 2025 02:16:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGURgYmHWDumCXTRkaYhVf9XwSz9b7gl2TQ2wHUSZZkFCUqJFO9cqaoCPyutX8+Eo4kVEBmrA==
X-Received: by 2002:a05:6000:2b10:b0:3a5:8a68:b815 with SMTP id
 ffacd0b85a97d-3a6ed660d0emr1189715f8f.46.1750842986645; 
 Wed, 25 Jun 2025 02:16:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f279dsm4167515f8f.64.2025.06.25.02.16.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Jun 2025 02:16:25 -0700 (PDT)
Message-ID: <de402ecb-8d45-4e42-a805-cd3aaef8dc93@redhat.com>
Date: Wed, 25 Jun 2025 11:16:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 12/14] arm/cpu: Add sysreg generation scripts
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 agraf@csgraf.de
Cc: shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20250617153931.1330449-1-cohuck@redhat.com>
 <20250617153931.1330449-13-cohuck@redhat.com> <87h60e1ies.fsf@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <87h60e1ies.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Connie,

On 6/17/25 5:45 PM, Cornelia Huck wrote:
> On Tue, Jun 17 2025, Cornelia Huck <cohuck@redhat.com> wrote:
>
>> diff --git a/scripts/arm-gen-cpu-sysregs-header.awk b/scripts/arm-gen-cpu-sysregs-header.awk
>> new file mode 100755
>> index 000000000000..f92bbbafa727
>> --- /dev/null
>> +++ b/scripts/arm-gen-cpu-sysregs-header.awk
>> @@ -0,0 +1,37 @@
>> +#!/bin/awk -f
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +# arm-gen-cpu-sysregs-header.awk: arm64 sysreg header include generator
>> +#
>> +# Usage: awk -f arm-gen-cpu-sysregs-header.awk $LINUX_PATH/arch/arm64/tools/sysreg
>> +
>> +BEGIN {
>> +    print "/* SPDX-License-Identifier: GPL-2.0-or-later */"
> FWIW, checkpatch.pl chokes on this:
>
> ^* matches null string many times in regex; marked by <-- HERE in m/^* <-- HERE /"$/ at scripts/checkpatch.pl line 1389.
> ERROR: Saw unacceptable licenses '*/"', valid choices for QEMU are:
> GPL-2.0-or-later
> GPL-2.0-only
> LGPL-2.1-only
> LGPL-2.1-or-later
> BSD-2-Clause
> BSD-3-Clause
> MIT
> total: 1 errors, 0 warnings, 76 lines checked

so don't we need to improve checkpatch.pl to silence this error?

Cheers

Eric
>
>
>> +    print "/* GENERATED FILE, DO NOT EDIT */"
>> +    print "/* use arm-gen-cpu-sysregs-header.awk to regenerate */"
>> +} END {
>> +    print ""
>> +}
>> +


