Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1964EC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 07:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnCDy-0005DN-UE; Wed, 26 Feb 2025 02:52:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCDx-0005Cq-JJ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:52:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tnCDv-0006cG-5P
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 02:52:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740556374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Uh1ZyKIADkJl5Wy0N6LpcNjfwUGgNimWNuICqHSKNLk=;
 b=NRXrxNGAMxK4erjaIZeh7X8ybavtk+DTT4L4NvhFfLfBPe013smyxDPGN8NiKAzFedMQSd
 BLwZa3aHCMq+zePz3Rs5jydbZ3Uu8X0LKrRUyD0Nb+eCD/rVzW/bJtEyb5c4TaPmeZn0Zr
 xGzqfYT/cQ2R+Wa++Ys1GN5b0ISqY4c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-FLyZ_f30OkG-zbsBafm_4g-1; Wed, 26 Feb 2025 02:52:50 -0500
X-MC-Unique: FLyZ_f30OkG-zbsBafm_4g-1
X-Mimecast-MFC-AGG-ID: FLyZ_f30OkG-zbsBafm_4g_1740556370
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43aafafe6b7so14985125e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 23:52:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740556369; x=1741161169;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Uh1ZyKIADkJl5Wy0N6LpcNjfwUGgNimWNuICqHSKNLk=;
 b=VWOW8YEsEuTxGPuCjbMbt9oac1pB+6avGjKE8fdVSdcLsoLXzvPD8iu0CbGM0P5rNA
 S/34/DW0Q0t50DCEJ1ki7kNbPjiOmrOhS2JWe7rdip6oh4s4bJDiY0RmKFNBKl8nuy+b
 3UyHHU5WqPXhg2PKcHpNaBU8O0W3QfiPKnduoim8UKbyGDiXGJ+K4MVfsYqa2buwOdqm
 ONEfn0laaRR4twcp3gjPgo7oD+IooTul8b//hr5hzIRQXSuX5sUFoGHJhvKX4UPgHexO
 Ee7P8ZEozsDAsdV3vXunwwA3meT+uq2KekOaad0owCzLgZ7ZKsNowm5q1x3Z75lY5Qlc
 x2Ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9aVixrYA87TDKSVy1TVSWt81p81wGyBioHmwfFdyE5SXP1EdzBbNp4rEFuR8PQeK6ZzUZsjaEyXSO@nongnu.org
X-Gm-Message-State: AOJu0Yx1YU2aNyEQ9e2CAFqz0mBQZIbVdAXt7sFg+Ri7qUFkYL0GS1L5
 L+3y6O3Pj/FA7Ad5fCCZsRflTe04pxL3pm4zVwnv0Ybw8QaAOXqE24gWCGrYsei9Q5oCd+uS7za
 mXnzTMBvWpIUhrOCywcbMBvsJgklRDEICsfXQ0oS83tY1vwwYpDv3
X-Gm-Gg: ASbGncthHDCOZYqTDHdIRO6oCULbYDAWqLpOrvjYSylTO3deE55d2VU/TWD6wiWP0CK
 wbJ+Lr4XjPD75zw5ZVzFSbjoupxN7deUDkhKr9hIkoUS1ZKN7iScwRveGMUYg7Z+GBDdKL4pEg1
 u1E2eUGqmmkct14XPN5SdEyBaSnO0jIH3ipV2fRGsuQP+OIq/0/1qYRgoXs9DQVLLSBgS7sGRtJ
 DnBpkmJ+gLTEo4KLKjPtA6cJbgFMCDpSWpDSNc4/qg5GV8lF7qqge08cAUwoDXgclrKVbPoqxqk
 dsbFnwQey4rmUlgvRti83uafVHUJw854NMl1IbFActVgKcaOa+rA21KndcM=
X-Received: by 2002:a05:6000:1848:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-390d4e9d839mr2018235f8f.0.1740556369571; 
 Tue, 25 Feb 2025 23:52:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGLuwi4+LTU/p9iKN4xplnlcFH/7aCVSrHoJ6JzGariiuacjtaWbfhVn9JOof5u/DXfk9lRkg==
X-Received: by 2002:a05:6000:1848:b0:385:fa26:f0d9 with SMTP id
 ffacd0b85a97d-390d4e9d839mr2018214f8f.0.1740556369196; 
 Tue, 25 Feb 2025 23:52:49 -0800 (PST)
Received: from ?IPV6:2a01:cb19:9004:d500:a732:5611:7f59:8bb3?
 ([2a01:cb19:9004:d500:a732:5611:7f59:8bb3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd883934sm4716336f8f.59.2025.02.25.23.52.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 23:52:47 -0800 (PST)
Message-ID: <e9296dd6-63ec-4a3e-9b2c-14d7cff200c7@redhat.com>
Date: Wed, 26 Feb 2025 08:52:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 19/36] vfio/migration: Convert bytes_transferred
 counter to atomic
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <dbb9b1047aca873a5ee0a91f352f282fe1004a15.1739994627.git.maciej.szmigiero@oracle.com>
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
In-Reply-To: <dbb9b1047aca873a5ee0a91f352f282fe1004a15.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 2/19/25 21:34, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> So it can be safety accessed from multiple threads.
> 
> This variable type needs to be changed to unsigned long since
> 32-bit host platforms lack the necessary addition atomics on 64-bit
> variables.
> 
> Using 32-bit counters on 32-bit host platforms should not be a problem
> in practice since they can't realistically address more memory anyway.

Is it useful to have VFIO on 32-bit host platforms ?

If not, VFIO PCI should depend on (AARCH64 || PPC64 || X86_64) and we
could drop this patch. Let's address that independently.

Thanks,

C.






> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 03890eaa48a9..5532787be63b 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -55,7 +55,7 @@
>    */
>   #define VFIO_MIG_DEFAULT_DATA_BUFFER_SIZE (1 * MiB)
>   
> -static int64_t bytes_transferred;
> +static unsigned long bytes_transferred;
>   
>   static const char *mig_state_to_str(enum vfio_device_mig_state state)
>   {
> @@ -391,7 +391,7 @@ static ssize_t vfio_save_block(QEMUFile *f, VFIOMigration *migration)
>       qemu_put_be64(f, VFIO_MIG_FLAG_DEV_DATA_STATE);
>       qemu_put_be64(f, data_size);
>       qemu_put_buffer(f, migration->data_buffer, data_size);
> -    bytes_transferred += data_size;
> +    qatomic_add(&bytes_transferred, data_size);
>   
>       trace_vfio_save_block(migration->vbasedev->name, data_size);
>   
> @@ -1013,12 +1013,12 @@ static int vfio_block_migration(VFIODevice *vbasedev, Error *err, Error **errp)
>   
>   int64_t vfio_mig_bytes_transferred(void)
>   {
> -    return bytes_transferred;
> +    return MIN(qatomic_read(&bytes_transferred), INT64_MAX);
>   }
>   
>   void vfio_reset_bytes_transferred(void)
>   {
> -    bytes_transferred = 0;
> +    qatomic_set(&bytes_transferred, 0);
>   }
>   
>   /*
> 


