Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC382CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 16:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iz0-0006DF-Gf; Mon, 22 Sep 2025 12:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iyB-0005fV-4R
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:01:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v0iy6-0005Y9-Tw
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 12:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758556844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TqnkRPYMA/T9RagLv0rq5SoXeR5+EGzxhSkSN5epycE=;
 b=ThU+zjlQxK/xL9R8lPVdpWBfyISJaBpJVCmzvL7FKq9rR6XkCwo8kMPiggfywGlvhu4hK9
 TMwpovG+CcsbqiVGtej2W11QSk5iP6Rsinn2Uurr6DRoMUUPIbjzK6ZxM3GVcNDf9haFh9
 IyUJ2k8/voH0rnzLckMBwG7RaZ8ithA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-c5W1yYehMXKB55I9lpUQgA-1; Mon, 22 Sep 2025 12:00:41 -0400
X-MC-Unique: c5W1yYehMXKB55I9lpUQgA-1
X-Mimecast-MFC-AGG-ID: c5W1yYehMXKB55I9lpUQgA_1758556840
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45de18e7eccso21804895e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 09:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556840; x=1759161640;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TqnkRPYMA/T9RagLv0rq5SoXeR5+EGzxhSkSN5epycE=;
 b=dI/hD5CxFYoH5qhsQNgJTkfeAKRDP0SfQ91Xmq5yz5NxgRfCg959FGmjfwwGPSQwSr
 nWxYeXNOKaH/64ElZuYMUM4MBpvx+Lvjl4cs3NxsWwVYiWu9hbIQ3PxvQlAIkcH2NhoT
 vWcyj5kgw5k+FmvH+/wN8/2ZM9XrMJsLH/YC53840RE5iTMyljYar/dYWEpF6IjTWWeY
 6OOQaUs8Io7x57iRPK7hjlnFHjLsPEYld8oE8klAUaMLs52R2eYEXx8utrxRRoDUR4+T
 3FaCkHEY6vf8zcOw4A/iZd3Qfs4WZNMUmFT6AKfoLbX6rX8S1d5D2ziPF2XDMxY0mOXS
 5zbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxUquOsfJcv9oJneMzmgw8Lq/NUV7fFvoOnrkWSRDc1EJfLdqNVIY6OZP/kVXLgR13TZvqA2BzPZvF@nongnu.org
X-Gm-Message-State: AOJu0YzKX+UL4AgCf+BmBgjLFM5vO4jmqwByDgwKoM6qu+Ilxas5giFd
 HElrkBboGHT+2ThgvkQ8mjlA5jHIv04rW0uhPYLXl7WnDXA+QGtWyKlAhaIic31qOLCcgr0HDnO
 bFY+O3Hfr+EhO3AnUjKIlNfUSxkigRa8LkoeuzhQsFxpeAdntRwRhK2va
X-Gm-Gg: ASbGnctNs9HbxMz6lyOVFejVVMa8kFVbF17UhFZLRQNHn7J+BmGbiRMe7mZWDkXEx57
 EMgahkZmZUsSa6ds4+8oHtxxpbw2qHG87Zn14+WIuYOPIWOmuOUzXtW92YOOm8SdFasOVcGIi+7
 mCWi1As2wa23liHmL2SLOzldhuoNcRlwpp9tOkuziVomPtxyGAHkAkHu5Gnq2WJROiVYM6vtzXb
 gjhVJP7xuw1FCk92vT4WzBR7XJ8LZxnTPrSGLcIMqqOQDrqBW7KCjHZcljDeOh/ygyDc5A0eRuw
 oTvdGYsyKN3rbaLGQNHIJVxYYwKXPHAH+lDCyoyrJ0xODmo2GmryxreqVWoNxkDq+Dja0rHqETU
 V/gQ=
X-Received: by 2002:a05:600c:4503:b0:45f:28dc:60ea with SMTP id
 5b1f17b1804b1-467ec92c224mr117815745e9.15.1758556840189; 
 Mon, 22 Sep 2025 09:00:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG84CV3To4RpFeJCqyepCqEL/XFOIJjpgTqMv1EEXXTExUTSTHDEVR3fFoPhjL1UF7n7bhgKA==
X-Received: by 2002:a05:600c:4503:b0:45f:28dc:60ea with SMTP id
 5b1f17b1804b1-467ec92c224mr117815155e9.15.1758556839642; 
 Mon, 22 Sep 2025 09:00:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46d1f3e1b03sm52436745e9.23.2025.09.22.09.00.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 09:00:39 -0700 (PDT)
Message-ID: <15399e70-fa4b-4792-9881-9dec59f0c832@redhat.com>
Date: Mon, 22 Sep 2025 18:00:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 5/8] migration: cpr-exec save and load
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>
References: <1758548985-354793-1-git-send-email-steven.sistare@oracle.com>
 <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
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
In-Reply-To: <1758548985-354793-6-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 9/22/25 15:49, Steve Sistare wrote:
> To preserve CPR state across exec, create a QEMUFile based on a memfd, and
> keep the memfd open across exec.  Save the value of the memfd in an
> environment variable so post-exec QEMU can find it.

Couldn't we preserve some memory to hand off to QEMU ? Like firmwares
An environment variable is a limited method.

Thanks,

C.



That's a short term hack right ? it's not even documented. I am sure
you something else in mind.

> These new functions are called in a subsequent patch.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   include/migration/cpr.h |  5 +++
>   migration/cpr-exec.c    | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
>   migration/meson.build   |  1 +
>   3 files changed, 100 insertions(+)
>   create mode 100644 migration/cpr-exec.c
> 
> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
> index 2b074d7..b84389f 100644
> --- a/include/migration/cpr.h
> +++ b/include/migration/cpr.h
> @@ -53,4 +53,9 @@ int cpr_get_fd_param(const char *name, const char *fdname, int index,
>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>   
> +QEMUFile *cpr_exec_output(Error **errp);
> +QEMUFile *cpr_exec_input(Error **errp);
> +void cpr_exec_persist_state(QEMUFile *f);
> +bool cpr_exec_has_state(void);
> +void cpr_exec_unpersist_state(void);
>   #endif
> diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
> new file mode 100644
> index 0000000..2c32e9c
> --- /dev/null
> +++ b/migration/cpr-exec.c
> @@ -0,0 +1,94 @@
> +/*
> + * Copyright (c) 2021-2025 Oracle and/or its affiliates.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/cutils.h"
> +#include "qemu/memfd.h"
> +#include "qapi/error.h"
> +#include "io/channel-file.h"
> +#include "io/channel-socket.h"
> +#include "migration/cpr.h"
> +#include "migration/qemu-file.h"
> +#include "migration/misc.h"
> +#include "migration/vmstate.h"
> +#include "system/runstate.h"
> +
> +#define CPR_EXEC_STATE_NAME "QEMU_CPR_EXEC_STATE"
> +
> +static QEMUFile *qemu_file_new_fd_input(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_input(ioc);
> +}
> +
> +static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
> +{
> +    g_autoptr(QIOChannelFile) fioc = qio_channel_file_new_fd(fd);
> +    QIOChannel *ioc = QIO_CHANNEL(fioc);
> +    qio_channel_set_name(ioc, name);
> +    return qemu_file_new_output(ioc);
> +}
> +
> +void cpr_exec_persist_state(QEMUFile *f)
> +{
> +    QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
> +    int mfd = dup(fioc->fd);
> +    char val[16];
> +
> +    /* Remember mfd in environment for post-exec load */
> +    qemu_clear_cloexec(mfd);
> +    snprintf(val, sizeof(val), "%d", mfd);
> +    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
> +}
> +
> +static int cpr_exec_find_state(void)
> +{
> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
> +    int mfd;
> +
> +    assert(val);
> +    g_unsetenv(CPR_EXEC_STATE_NAME);
> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
> +    return mfd;
> +}
> +
> +bool cpr_exec_has_state(void)
> +{
> +    return g_getenv(CPR_EXEC_STATE_NAME) != NULL;
> +}
> +
> +void cpr_exec_unpersist_state(void)
> +{
> +    int mfd;
> +    const char *val = g_getenv(CPR_EXEC_STATE_NAME);
> +
> +    g_unsetenv(CPR_EXEC_STATE_NAME);
> +    assert(val);
> +    assert(!qemu_strtoi(val, NULL, 10, &mfd));
> +    close(mfd);
> +}
> +
> +QEMUFile *cpr_exec_output(Error **errp)
> +{
> +    int mfd = memfd_create(CPR_EXEC_STATE_NAME, 0);

The build should be adjusted for Linux only.

Thanks,

C.



> +
> +    if (mfd < 0) {
> +        error_setg_errno(errp, errno, "memfd_create failed");
> +        return NULL;
> +    }
> +
> +    return qemu_file_new_fd_output(mfd, CPR_EXEC_STATE_NAME);
> +}
> +
> +QEMUFile *cpr_exec_input(Error **errp)
> +{
> +    int mfd = cpr_exec_find_state();
> +
> +    lseek(mfd, 0, SEEK_SET);
> +    return qemu_file_new_fd_input(mfd, CPR_EXEC_STATE_NAME);
> +}
> diff --git a/migration/meson.build b/migration/meson.build
> index 0f71544..16909d5 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -16,6 +16,7 @@ system_ss.add(files(
>     'channel-block.c',
>     'cpr.c',
>     'cpr-transfer.c',
> +  'cpr-exec.c',
>     'cpu-throttle.c',
>     'dirtyrate.c',
>     'exec.c',


