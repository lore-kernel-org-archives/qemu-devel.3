Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFBCD2C560
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3G5b-0004eE-7k; Tue, 22 Oct 2024 10:42:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3G5Z-0004Zg-2d
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t3G5X-0000Ky-8z
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729608142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=/imVAGg71417YY/uV61EHCLH5EefqsNRT4zXM7SlDF4=;
 b=gs/JLe9NAdCrouxz29m/Z81viVHxcDJqnV7gRc0WzRuqQ7270PH9OrJpZMM3DxcLwzEEdp
 /Cg1CfFWBAeRW8kvemVOcvH+Y4MUYfZegmNA4GfmXaLnbeikIj0LPdGBMdQhmO73XhFHma
 hx2g/hn76XcLSP5PjH99jhgcIK3E4Mk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-B37UUjyfMEa461cF-22Oew-1; Tue, 22 Oct 2024 10:42:18 -0400
X-MC-Unique: B37UUjyfMEa461cF-22Oew-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d59ad50f3so2438927f8f.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:42:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729608137; x=1730212937;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/imVAGg71417YY/uV61EHCLH5EefqsNRT4zXM7SlDF4=;
 b=H/qEDVwNxbVh09moJSNpDnOD3BPz40swCeU0EBne9/bybYgmF5lJzoifvBEQBJYgKX
 IIh7mCPcW/brT5h9YY5ZZsOlqHAeYFdc7qlpRBy98SmNLzpMJ3tyz1DqeLQrsmAyFCrZ
 Rr4wRIsTjxXknCNBQP/AWy0ICBiX6F9QOQ6lZfS9T2XEfwyTjEpsCF5PM+3QYP/GCdGt
 PXxXmigmF6A+/B9UlW9+Zb+H8xfBNwh4wqbG85fUI6M1le4mCTPHgsAwgK5HBQccFyX6
 6Gi9oeRdOT0S1p2dDHh/YWUSXMTHcCoqGssA9M3c+UyYhLQa6qLh8qB2G0KPEC9+iOXw
 f11w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXILKOZ5ghDupNv/0UwVxFLKWDpLvyo/PDeBAm7EJfJqNuRokUlQ9NP4jTIFQbSUXjfHB8sTrmbrj39@nongnu.org
X-Gm-Message-State: AOJu0YzHbTNVcCtwC0u2u2c+mk6yU49OlHEwKAcuMIvLOqDQH/XGGt04
 47E2gFWQYtzNlUnbqLGrx4BH0tP6XmKrDBlvgTAOoCF6T25k5LjyEKYGawBotBg4fWQSJnoHD0R
 AZnRKV69RKWZCLYJbW0cHfOEDCWn40SqO2kwFPkD3v7RGafJiov4V
X-Received: by 2002:a5d:67cd:0:b0:37d:5301:6edb with SMTP id
 ffacd0b85a97d-37eb48a778amr9091682f8f.57.1729608136668; 
 Tue, 22 Oct 2024 07:42:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4ze73mUCRsG+s3cy6zxCraYaY7SLzLeHbCourcCwHsBGi8NwA1AHicyCa8d3aTS4THrzQEA==
X-Received: by 2002:a5d:67cd:0:b0:37d:5301:6edb with SMTP id
 ffacd0b85a97d-37eb48a778amr9091662f8f.57.1729608136248; 
 Tue, 22 Oct 2024 07:42:16 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37ee0b9432fsm6775086f8f.83.2024.10.22.07.42.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Oct 2024 07:42:15 -0700 (PDT)
Message-ID: <c6aa909e-aad8-472b-a2b4-5c8d0af5df7b@redhat.com>
Date: Tue, 22 Oct 2024 16:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] vfio/migration: Refactor
 vfio_vmstate_change/_prepare() error reporting
To: Peter Xu <peterx@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <20241020130108.27148-1-avihaih@nvidia.com>
 <20241020130108.27148-3-avihaih@nvidia.com>
 <cfca06dd-cfd3-4a36-a80f-b8e2ddecbf88@redhat.com> <ZxZ4Y5KSNPcuN8-X@x1n>
 <68d60abe-32b6-49b3-bc60-6c92909252f0@redhat.com> <ZxaHPo7GRPuby5ky@x1n>
 <3e0d59e7-699e-47b2-a6dc-204d64e07895@nvidia.com>
 <d172a1b8-9e6f-42ef-a78c-decb5c9a2944@redhat.com> <Zxe2sZLyIa3XbVeZ@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
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
In-Reply-To: <Zxe2sZLyIa3XbVeZ@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.519,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/22/24 16:29, Peter Xu wrote:
> On Tue, Oct 22, 2024 at 03:24:56PM +0200, Cédric Le Goater wrote:
>> On 10/22/24 11:38, Avihai Horon wrote:
>>>
>>> On 21/10/2024 19:54, Peter Xu wrote:
>>>> External email: Use caution opening links or attachments
>>>>
>>>>
>>>> On Mon, Oct 21, 2024 at 06:43:13PM +0200, Cédric Le Goater wrote:
>>>>> Hello,
>>>>>
>>>>>> IIUC the migration thread should always see valid migration object, as it
>>>>>> takes one refcount at the entrance of migration_thread():
>>>>>>
>>>>>>        object_ref(OBJECT(s));
>>>>> Could the migration have failed before ? in migrate_fd_connect()
>>>> I just noticed it's a vm state change notifier..
>>>
>>> Yep.
>>> I stumbled upon this bug by accident when running on a buggy machine.
>>> Migration wasn't involved, I just started the VM, shut it down and got the assert (as my VFIO device was faulty and errored on RUNNING->STOP state change).
>>>
>>> You can repro it by forcefully triggering an error on *->STOP transition:
>>>
>>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>>> index 17199b73ae..d41cb7c634 100644
>>> --- a/hw/vfio/migration.c
>>> +++ b/hw/vfio/migration.c
>>> @@ -831,7 +831,9 @@ static void vfio_vmstate_change(void *opaque, bool running, RunState state)
>>>        }
>>>
>>>        ret = vfio_migration_set_state_or_reset(vbasedev, new_state, &local_err);
>>> -    if (ret) {
>>> +    if (ret || new_state == VFIO_DEVICE_STATE_STOP) {
>>> +        ret = -1;
>>> +        error_setg(&local_err, "%s: forced error", vbasedev->name);
>>>            /*
>>>             * Migration should be aborted in this case, but vm_state_notify()
>>>             * currently does not support reporting failures.
>>>
>>>>
>>>> If so, maybe VFIO could refer to its internal states showing that it's
>>>> during a migration first (so as to guarantee the migration object is valid;
>>>> e.g., only after save_setup() but before save_cleanup() hooks are invoked).
>>>
>>> It's an option, but I think it's a bit awkward as we'd need to check
>>> that VFIOMigration->data_buffer is set
>>
>> That's what I was looking at too. It works. It feels a bit awkward
>> indeed. We could hide the details in an helper routine though.
>>
>>> or add a new flag.
>>
>> yes that's another solution.
>>
>> Peter,
>>
>> I wonder if we could grab a ref on current_migration in save_setup(),
>> store it under VFIOMigration and drop it save_cleanup() ?
> 
> VFIO can definitely do that, but I am not sure how that would help.. as I
> think the migration object can never go away anyway during setup->cleanup,
> so taking that extra refcount shouldn't change anything.

It won't be but we would have a VFIOMigration::MigrationState pointer to
test in the vmstate change handler, which is a bit cleaner than testing
migration->data_buffer. Just an idea. I am not convinced myself either.

> IOW, AFAICT this bug is triggered only when without migration at all.
> 
>>
>>
>>> Besides that, as Cedric pointed out, VFIO code calls migration_is_setup_or_active() which can also be unsafe, as it might be invoked after migration object has been freed.
>>>
>>> Maybe a simpler solution would be to extend the the migration object lifetime?
>>> Looking at commit history, you can see that commit 1f8956041ad3 ("migration: finalize current_migration object") added migration object finalization at the very end of qemu cleanup.
>>> Then came commit 892ae715b6bc ("migration: Cleanup during exit") and moved the migration object finalization to the beginning of qemu cleanup (before stopping the VM etc.).
>>>
>>> If so, the fix could be something like the below?
>>>
>>> -------------8<-------------
>>> diff --git a/include/migration/misc.h b/include/migration/misc.h
>>> index bfadc5613b..5eb099349a 100644
>>> --- a/include/migration/misc.h
>>> +++ b/include/migration/misc.h
>>> @@ -52,6 +52,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>>>
>>>    /* migration/migration.c */
>>>    void migration_object_init(void);
>>> +void migration_object_finalize(void);
>>>    void migration_shutdown(void);
>>>    bool migration_is_idle(void);
>>>    bool migration_is_active(void);
>>> diff --git a/migration/migration.c b/migration/migration.c
>>> index 021faee2f3..9eaa7947bc 100644
>>> --- a/migration/migration.c
>>> +++ b/migration/migration.c
>>> @@ -265,6 +265,11 @@ void migration_object_init(void)
>>>        dirty_bitmap_mig_init();
>>>    }
>>>
>>> +void migration_object_finalize(void)
>>> +{
>>> +    object_unref(OBJECT(current_migration));
>>> +}
>>> +
>>>    typedef struct {
>>>        QEMUBH *bh;
>>>        QEMUBHFunc *cb;
>>> @@ -330,7 +335,6 @@ void migration_shutdown(void)
>>>         * stop the migration using this structure
>>>         */
>>>        migration_cancel(NULL);
>>> -    object_unref(OBJECT(current_migration));
>>>
>>>        /*
>>>         * Cancel outgoing migration of dirty bitmaps. It should
>>> diff --git a/system/runstate.c b/system/runstate.c
>>> index c2c9afa905..fa823f5e72 100644
>>> --- a/system/runstate.c
>>> +++ b/system/runstate.c
>>> @@ -930,5 +930,6 @@ void qemu_cleanup(int status)
>>>        monitor_cleanup();
>>>        qemu_chr_cleanup();
>>>        user_creatable_cleanup();
>>> +    migration_object_finalize();
>>>        /* TODO: unref root container, check all devices are ok */
>>>    }
>>> -------------8<-------------
>>
>> 892ae715b6bc was trying to fix potential use-after-free issues.
>>
>> I think it is safer to introduce an helper routine checking
>> (in some ways) if a migration is in progress than partially
>> revert 892ae715b6bc.
> 
> Right, Dave also mentioned something in 892ae715b6bc about moving it
> earlier:
> 
>      We do this a bit earlier; so hopefully migration gets out of the way
>      before all the devices etc are freed.
> 
> But I don't know the relationship on device free() v.s. the migration
> object.  We might at least want to figure that out if we want to move it
> again.
> 
> I notice that vdpa also started using migration_is_setup_or_active(), so if
> it's used in more places, maybe indeed we can consider making them safe to
> be called at any phase of QEMU.
> 
> Logically it is safe in vm state change hook always because it has the BQL
> and the object can only be freed when with BQL.
> 
> So let me send a small patch later to hopefully make all these exported
> functions (including migration_file_set_error() in this case, logically
> anything in migration/misc.h) safe to be called without migration.
> 

OK.

Thanks

C.


