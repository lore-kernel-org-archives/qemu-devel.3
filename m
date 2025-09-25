Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE74CAC5A5
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 07:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1g97-0005CQ-MZ; Thu, 25 Sep 2025 03:12:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1g92-0005AM-By
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v1g8o-0005jU-P9
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 03:11:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758784298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QTGm+sHnpgxxDoXuzWr57M8MduTFGcHhiSZqNyZ0JMY=;
 b=epRkCCy0HYeuFDShdd5aiBHOvR2Q7eDG5ufIzPF9vQi3UR52PRXN1wCDrW6bpfZSwPIGy1
 uNCwEbkLd7tSTm63Mlb98YclwAa7Ihi1QtzSb85rfIFfbIO/rmdnAch9agiqRFTWdr0A58
 kFwSJ5rBoalv5bGtRCbBr0hYqKaat7Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-U7Rf6bwJNB2SxMPpsuzuSQ-1; Thu, 25 Sep 2025 03:11:36 -0400
X-MC-Unique: U7Rf6bwJNB2SxMPpsuzuSQ-1
X-Mimecast-MFC-AGG-ID: U7Rf6bwJNB2SxMPpsuzuSQ_1758784296
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b98de0e34so4906375e9.0
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 00:11:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758784295; x=1759389095;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QTGm+sHnpgxxDoXuzWr57M8MduTFGcHhiSZqNyZ0JMY=;
 b=gNUzTan/bL04gS+l8otIrpgzxBQ9WmbYWqcfObuA+MFCiTy+/kY9jvh2BI1dZuhwhi
 WHV/PgkRnIrg0Wa2VOpGkuVhjQdcVQXsRu0I0gS/vZaoWqr9HGYmgjVzMX0rZL0tTbEh
 cK04X/+iY7JRGIWpgA/j22/5CDuBlsgNBF8wYMJ7HWHxs/0iu1c9LUjMDa4W37aXRVb8
 GR9WhTLkxeyZxnIbif1QtLj6nd2K03You+CaUnJr+kAEiUh2thx5GMU94FN/EykDzD2s
 wMRASHBbZX63FCCDwk2AXUdIJKPp1FPOnOUQxOp7Xyf3aI8J20vzpLq+5AhWBVfuXL5T
 NysQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/5alUpxsEEo4R/FtL7ihP1dPTnjSeC1wZeHzzTJqn5pODKCm2VS1/E8dgzsfvoF9a8YeKr5b5HvNe@nongnu.org
X-Gm-Message-State: AOJu0Yy0mpuJnXxpJ5sbLMGBX5FmpQJ9KgHa1BRiFEqODtTfL1z254n+
 Kj/kG1YCAUBey69XVkIAo0TxSXlYeFSgadqPlyQFDzhc1FAi7cghoqRWEGk7l1HFxSlpRthnkIy
 cJ9bmxuvVcM9e5QvIBGSDCjpwsWz+LlilPWqoZyHmZpFKN8mSdseobxUn
X-Gm-Gg: ASbGnctUITDIaCgCLeOgQOQzxqmhhiWM95UZ7ffg8NGHj+Zr3VePmyhvpPdLBHoktTH
 +iejg+tDyL/05Py4FzgAm24GM/GOk/gi0PS9kKjETl15BsSuqqHpaolEEvGhcTC2iEwfTI1ampQ
 7OurXfx7j/+pgjTdnQNUYCOWg3HJpi1jNASGt4HYTBd48e6oFqcvcL6EmDMG1rEdoerOeg5aoXU
 etRygQuayD3nJhUjQYDO+Y8p/BVLTa26ZblfNCUMmOpuzOkKakG0KKcZpkESPFQlj0VWJ2BmjJ5
 VWBJa342uqPDmYqqrd9yamSMjIv04U0n/f4XNrV0mYN3qYvG0YAOLSsOgwKwh+RXqm+0HJMAhiS
 q0tw=
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id
 5b1f17b1804b1-46e330a1a9cmr13442115e9.22.1758784295522; 
 Thu, 25 Sep 2025 00:11:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsQ0nnklQZSZSwbMtrzFheUiTxelIM86Pm3k+kqDIo3GsuBpuaSVcJHPHfHpYgCtldS53F0w==
X-Received: by 2002:a05:600c:154a:b0:46e:330a:1762 with SMTP id
 5b1f17b1804b1-46e330a1a9cmr13441815e9.22.1758784294721; 
 Thu, 25 Sep 2025 00:11:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a996da2sm74488115e9.5.2025.09.25.00.11.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Sep 2025 00:11:34 -0700 (PDT)
Message-ID: <6d5b95e4-1d50-4b70-8d40-9031f3735d56@redhat.com>
Date: Thu, 25 Sep 2025 09:11:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
 <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
 <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 xsFNBFu8o3UBEADP+oJVJaWm5vzZa/iLgpBAuzxSmNYhURZH+guITvSySk30YWfLYGBWQgeo
 8NzNXBY3cH7JX3/a0jzmhDc0U61qFxVgrPqs1PQOjp7yRSFuDAnjtRqNvWkvlnRWLFq4+U5t
 yzYe4SFMjFb6Oc0xkQmaK2flmiJNnnxPttYwKBPd98WfXMmjwAv7QfwW+OL3VlTPADgzkcqj
 53bfZ4VblAQrq6Ctbtu7JuUGAxSIL3XqeQlAwwLTfFGrmpY7MroE7n9Rl+hy/kuIrb/TO8n0
 ZxYXvvhT7OmRKvbYuc5Jze6o7op/bJHlufY+AquYQ4dPxjPPVUT/DLiUYJ3oVBWFYNbzfOrV
 RxEwNuRbycttMiZWxgflsQoHF06q/2l4ttS3zsV4TDZudMq0TbCH/uJFPFsbHUN91qwwaN/+
 gy1j7o6aWMz+Ib3O9dK2M/j/O/Ube95mdCqN4N/uSnDlca3YDEWrV9jO1mUS/ndOkjxa34ia
 70FjwiSQAsyIwqbRO3CGmiOJqDa9qNvd2TJgAaS2WCw/TlBALjVQ7AyoPEoBPj31K74Wc4GS
 Rm+FSch32ei61yFu6ACdZ12i5Edt+To+hkElzjt6db/UgRUeKfzlMB7PodK7o8NBD8outJGS
 tsL2GRX24QvvBuusJdMiLGpNz3uqyqwzC5w0Fd34E6G94806fwARAQABzSJDw6lkcmljIExl
 IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+wsGRBBMBCAA7FiEEoPZlSPBIlev+awtgUaNDx8/7
 7KEFAmTLlVECGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQUaNDx8/77KG0eg//
 S0zIzTcxkrwJ/9XgdcvVTnXLVF9V4/tZPfB7sCp8rpDCEseU6O0TkOVFoGWM39sEMiQBSvyY
 lHrP7p7E/JYQNNLh441MfaX8RJ5Ul3btluLapm8oHp/vbHKV2IhLcpNCfAqaQKdfk8yazYhh
 EdxTBlzxPcu+78uE5fF4wusmtutK0JG0sAgq0mHFZX7qKG6LIbdLdaQalZ8CCFMKUhLptW71
 xe+aNrn7hScBoOj2kTDRgf9CE7svmjGToJzUxgeh9mIkxAxTu7XU+8lmL28j2L5uNuDOq9vl
 hM30OT+pfHmyPLtLK8+GXfFDxjea5hZLF+2yolE/ATQFt9AmOmXC+YayrcO2ZvdnKExZS1o8
 VUKpZgRnkwMUUReaF/mTauRQGLuS4lDcI4DrARPyLGNbvYlpmJWnGRWCDguQ/LBPpbG7djoy
 k3NlvoeA757c4DgCzggViqLm0Bae320qEc6z9o0X0ePqSU2f7vcuWN49Uhox5kM5L86DzjEQ
 RHXndoJkeL8LmHx8DM+kx4aZt0zVfCHwmKTkSTQoAQakLpLte7tWXIio9ZKhUGPv/eHxXEoS
 0rOOAZ6np1U/xNR82QbF9qr9TrTVI3GtVe7Vxmff+qoSAxJiZQCo5kt0YlWwti2fFI4xvkOi
 V7lyhOA3+/3oRKpZYQ86Frlo61HU3r6d9wzOwU0EW7yjdQEQALyDNNMw/08/fsyWEWjfqVhW
 pOOrX2h+z4q0lOHkjxi/FRIRLfXeZjFfNQNLSoL8j1y2rQOs1j1g+NV3K5hrZYYcMs0xhmrZ
 KXAHjjDx7FW3sG3jcGjFW5Xk4olTrZwFsZVUcP8XZlArLmkAX3UyrrXEWPSBJCXxDIW1hzwp
 bV/nVbo/K9XBptT/wPd+RPiOTIIRptjypGY+S23HYBDND3mtfTz/uY0Jytaio9GETj+fFis6
 TxFjjbZNUxKpwftu/4RimZ7qL+uM1rG1lLWc9SPtFxRQ8uLvLOUFB1AqHixBcx7LIXSKZEFU
 CSLB2AE4wXQkJbApye48qnZ09zc929df5gU6hjgqV9Gk1rIfHxvTsYltA1jWalySEScmr0iS
 YBZjw8Nbd7SxeomAxzBv2l1Fk8fPzR7M616dtb3Z3HLjyvwAwxtfGD7VnvINPbzyibbe9c6g
 LxYCr23c2Ry0UfFXh6UKD83d5ybqnXrEJ5n/t1+TLGCYGzF2erVYGkQrReJe8Mld3iGVldB7
 JhuAU1+d88NS3aBpNF6TbGXqlXGF6Yua6n1cOY2Yb4lO/mDKgjXd3aviqlwVlodC8AwI0Sdu
 jWryzL5/AGEU2sIDQCHuv1QgzmKwhE58d475KdVX/3Vt5I9kTXpvEpfW18TjlFkdHGESM/Jx
 IqVsqvhAJkalABEBAAHCwV8EGAECAAkFAlu8o3UCGwwACgkQUaNDx8/77KEhwg//WqVopd5k
 8hQb9VVdk6RQOCTfo6wHhEqgjbXQGlaxKHoXywEQBi8eULbeMQf5l4+tHJWBxswQ93IHBQjK
 yKyNr4FXseUI5O20XVNYDJZUrhA4yn0e/Af0IX25d94HXQ5sMTWr1qlSK6Zu79lbH3R57w9j
 hQm9emQEp785ui3A5U2Lqp6nWYWXz0eUZ0Tad2zC71Gg9VazU9MXyWn749s0nXbVLcLS0yop
 s302Gf3ZmtgfXTX/W+M25hiVRRKCH88yr6it+OMJBUndQVAA/fE9hYom6t/zqA248j0QAV/p
 LHH3hSirE1mv+7jpQnhMvatrwUpeXrOiEw1nHzWCqOJUZ4SY+HmGFW0YirWV2mYKoaGO2YBU
 wYF7O9TI3GEEgRMBIRT98fHa0NPwtlTktVISl73LpgVscdW8yg9Gc82oe8FzU1uHjU8b10lU
 XOMHpqDDEV9//r4ZhkKZ9C4O+YZcTFu+mvAY3GlqivBNkmYsHYSlFsbxc37E1HpTEaSWsGfA
 HQoPn9qrDJgsgcbBVc1gkUT6hnxShKPp4PlsZVMNjvPAnr5TEBgHkk54HQRhhwcYv1T2QumQ
 izDiU6iOrUzBThaMhZO3i927SG2DwWDVzZltKrCMD1aMPvb3NU8FOYRhNmIFR3fcalYr+9gD
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e8766c16-5f8e-4b3d-8808-42158d28b549@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 9/24/25 20:16, Steven Sistare wrote:
> On 9/22/2025 12:00 PM, Cédric Le Goater wrote:
>> On 9/22/25 15:49, Steve Sistare wrote:
>>> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
>>> keep the memfd open across exec.  Save the value of the memfd in an
>>> environment variable so post-exec QEMU can find it.
>>
>> Couldn't we preserve some memory to hand off to QEMU ? Like firmwares
>> An environment variable is a limited method.
> 
> There is no upside in making this more complicated.  We only need to
> pass one tidbit of information -- the file descriptor number of the memfd
> that contains all other information.

Please adjust the build for windows, memfd is Linux only.


>> Thanks,
>>
>> C.
>>
>> That's a short term hack right ? it's not even documented. 
> 
> It is an implementation detail, known only to the matched saving
> and loading functions inside qemu.  No one else needs to know, so
> no documentation.

ok. Fair enough.

Thanks,

C.


> 
> - Steve
> 
>> I am sure
>> you something else in mind.
>>
>>> These new functions are called in a subsequent patch.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>   include/migration/cpr.h |  5 +++
>>>   migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>   migration/meson.build   |  1 +
>>>   3 files changed, 100 insertions(+)
>>>   create mode 100644 migration/cpr-exec.c
>>>
>>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>>> index 2b074d7..b84389f 100644
>>> --- a/include/migration/cpr.h
>>> +++ b/include/migration/cpr.h
>>> @@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>>> +QEMUFile *cpr_exec_output(Error **errp);
>>> +QEMUFile *cpr_exec_input(Error **errp);
>>> +void cpr_exec_persist_state(QEMUFile *f);
>>> +bool cpr_exec_has_state(void);
>>> +void cpr_exec_unpersist_state(void);
>>>   #endif
>>> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>>> new file mode 100644
>>> index 0000000..2c32e9c
>>> --- /dev/null
>>> +++ b/migration/cpr-exec.c
>>> @@ -0,0 +1,94 @@
>>> +/*
>>> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
>>> + *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/cutils.h"
>>> +#include "qemu/memfd.h"
>>> +#include "qapi/error.h"
>>> +#include "io/channel-file.h"
>>> +#include "io/channel-socket.h"
>>> +#include "migration/cpr.h"
>>> +#include "migration/qemu-file.h"
>>> +#include "migration/misc.h"
>>> +#include "migration/vmstate.h"
>>> +#include "system/runstate.h"
>>> +
>>> +#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
>>> +
>>> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
>>> +{
>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>> +    qio_channel_set_name(ioc, name);
>>> +    return qemu_file_new_input(ioc);
>>> +}
>>> +
>>> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>>> +{
>>> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
>>> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
>>> +    qio_channel_set_name(ioc, name);
>>> +    return qemu_file_new_output(ioc);
>>> +}
>>> +
>>> +void cpr_exec_persist_state(QEMUFile *f)
>>> +{
>>> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>>> +    int mfd = dup(fioc->fd);
>>> +    char val[16];
>>> +
>>> +    /* Remember mfd in environment for post-exec load */
>>> +    qemu_clear_cloexec(mfd);
>>> +    snprintf(val, sizeof(val), "%d", mfd);
>>> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
>>> +}
>>> +
>>> +static int cpr_exec_find_state(void)
>>> +{
>>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>>> +    int mfd;
>>> +
>>> +    assert(val);
>>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>>> +    return mfd;
>>> +}
>>> +
>>> +bool cpr_exec_has_state(void)
>>> +{
>>> +    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
>>> +}
>>> +
>>> +void cpr_exec_unpersist_state(void)
>>> +{
>>> +    int mfd;
>>> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
>>> +
>>> +    g_unsetenv(CPR_EXEC_STATE_NAME);
>>> +    assert(val);
>>> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
>>> +    close(mfd);
>>> +}
>>> +
>>> +QEMUFile *cpr_exec_output(Error **errp)
>>> +{
>>> +    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);
>>
>> The build should be adjusted for Linux only.
>>
>> Thanks,
>>
>> C.
>>
>>
>>
>>> +
>>> +    if (mfd < 0) {
>>> +        error_setg_errno(errp, errno, "memfd_create failed");
>>> +        return NULL;
>>> +    }
>>> +
>>> +    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
>>> +}
>>> +
>>> +QEMUFile *cpr_exec_input(Error **errp)
>>> +{
>>> +    int mfd = cpr_exec_find_state();
>>> +
>>> +    lseek(mfd, 0, SEEK_SET);
>>> +    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
>>> +}
>>> diff --git a/migration/meson.build b/migration/meson.build
>>> index 0f71544..16909d5 100644
>>> --- a/migration/meson.build
>>> +++ b/migration/meson.build
>>> @@ -16,6 +16,7 @@ system_ss.add(files(
>>>     'channel-block.c',
>>>     'cpr.c',
>>>     'cpr-transfer.c',
>>> +  'cpr-exec.c',
>>>     'cpu-throttle.c',
>>>     'dirtyrate.c',
>>>     'exec.c',
>>
> 


