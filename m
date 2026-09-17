Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AC4C982D1
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7C42-0006J7-IH; Thu, 17 Sep 2026 09:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x7C40-0006Eg-5Q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:22:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x7C3y-00017e-CN
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 09:22:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789651325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W4nmdyxXWVb8DrLIsuXKLwlRSXtmTgV8sASM5VC8yY0=;
 b=fvS/TkyHSCvpOMtyf6UsNl88toLg70HZEOsfhME8znINvWiOKmdSBhHQIhjUlU/VScBWcr
 BuAvrqxGuQtH9pS5gnMH6puTsZQ2nZQzwKrW28NZRqpiAEr/D71/eOgRf/NwsokpDeU7v1
 Bs+A4kH72/KYbQekxv8DMddqy4gfoSQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-mTaUOCN2ODy9lpNklvpHag-1; Thu, 17 Sep 2026 09:22:04 -0400
X-MC-Unique: mTaUOCN2ODy9lpNklvpHag-1
X-Mimecast-MFC-AGG-ID: mTaUOCN2ODy9lpNklvpHag_1789651323
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-472c330e555so444666f8f.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 06:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789651323; x=1790256123; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=W4nmdyxXWVb8DrLIsuXKLwlRSXtmTgV8sASM5VC8yY0=;
 b=fz+Uy4p2zVrosplHyGMIpiGcqYkT0hf6Mx7GJycCZ81xi9xQx/Bgk2yk26BSqmUZZG
 pC5KBwIhOiupjPRiMXbJKlhqbq18isqIKHgCzOEZoLffwvNx5PfoXxs0igvH9K+RbCBS
 2Z7PsWRoKl1PTxqXCmvgKJ+SSaPGYNSSoulCDZ2w25oV3qV2E7VxrYBMVUKkRiwgHeW3
 lXUVIMQRr9tKdxgHxaC+ikIQ+QxgqxM0kxYPhH+BIb3FN+DegqF6sC5iKI+lQChwRWOd
 IF77EDLxcX8cRkiMdMQcDHUmOU85mxwXeQ4E+5b2iZtWpEgDWOR9+kNf4m3VgzqJ48by
 tqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651323; x=1790256123;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=W4nmdyxXWVb8DrLIsuXKLwlRSXtmTgV8sASM5VC8yY0=;
 b=dJeznyrTAkPOAI4HAOQ+/UgoHZ5zUeX4IzPJfFMUx74J6v15iPp6Q2jVDWnuye0z2p
 m+aGfczTszH4dXq5+Fjvjy5HvU5h0YaU4NCLgNLPtr0cswRXoP4THRQkEWvmaRBrHmyJ
 aGnLYQaYMwH+5lfS+KUsiiluqXTTYZlwnVa1/uL4GramVZGZdyo8U8ry6W9GXqE9O/08
 eiJvKiEo/UVRW3kkWqp6G0c3N2wLcptq3yIjdc3rWB8b2V9CXDJt6/9vSDScmbnn0xx5
 hODqSLVQE7fD1qxEb2dzpTRJrdvpTQjdFglCwB2F4DXyBAH6B+q98zwTJf7xhP5PDqzL
 34cg==
X-Gm-Message-State: AFuF++k5Xfyg2F0cvLORfWOEAlNwnH6paKh3gzNjjIeDgB7uG+CJM5Wm
 IPiNHviH09g5yh9yvAmY3bHK6PuOfHKEFcpSmYt6yxdoGQmzxc7E/QkCEQ9ubkS3QEOXhdI9dGb
 wWNloWe6UXG+ATLBJJrVXC81BtEvEQDLdpirvSykKF3oZsNdbju/T6Ese
X-Gm-Gg: AYBFou04ApmtI+VCCCjm4ZBbNm10J+ZP84qPxL7cRDnYuTtRP8GrwvMzk17EKtyE3h5
 seO2FK69gwcRx7RaLQGw6oY20n7g5/iDvFlanaYCR0ESlv9phR7vCC/nB4HJtVmGOTPpsljNUgy
 nJ41YTsBd7MAn/qLM7+IxjbBBDshh2l/Sm2EgOytJI5gyCEe9D7ehwpoJBNB1lsVycXwBfQv9wm
 vwkMyrxTnDmyviVZpHyabEY0CA2gkBUK06Av03ncvi0318dBoahn2EZx+Bm9G2cnnPPFCpOc/+S
 utqJTWVPszTsLeC1EZkWPFf6bplxsjqtBrpvAS0VsjJV2e/Es2FdGslbAOjvqPSH5tkKO6Vt+pF
 f7OeZj8zhp9BblmZcp6j7ZZYEfypcGU2MFAHI6q1W7U9FCw==
X-Received: by 2002:a05:6000:2382:b0:487:1662:cf4c with SMTP id
 ffacd0b85a97d-4871662e42bmr3521161f8f.7.1789651322708; 
 Thu, 17 Sep 2026 06:22:02 -0700 (PDT)
X-Received: by 2002:a05:6000:2382:b0:487:1662:cf4c with SMTP id
 ffacd0b85a97d-4871662e42bmr3521094f8f.7.1789651322212; 
 Thu, 17 Sep 2026 06:22:02 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33d93sm14826582f8f.22.2026.09.17.06.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:22:01 -0700 (PDT)
Date: Thu, 17 Sep 2026 15:21:54 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, bchaney@akamai.com, mark.kanda@oracle.com, 
 farosas@suse.de, den@openvz.org, clg@redhat.com, philmd@oss.qualcomm.com, 
 maciej.szmigiero@oracle.com, mst@redhat.com, dongli.zhang@oracle.com,
 peterx@redhat.com
Subject: Re: [PATCH v6 14/14] vhost-vsock: hand off device ownership across CPR
Message-ID: <aqvpJ-6sjNgsjHrH@sgarzare-redhat>
References: <20260915-up-vsock-vhost-v5-v6-0-4d31b2dc6afd@virtuozzo.com>
 <20260915-up-vsock-vhost-v5-v6-14-4d31b2dc6afd@virtuozzo.com>
 <aqrDcFrLWGBF_-pg@sgarzare-redhat>
 <34444e5c-3468-4287-9fbc-b0a9693817eb@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <34444e5c-3468-4287-9fbc-b0a9693817eb@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 17, 2026 at 03:45:52PM +0300, Andrey Drobyshev wrote:
>On 9/16/26 7:33 PM, Stefano Garzarella wrote:
>> On Tue, Sep 15, 2026 at 11:59:50PM +0300, Andrey Drobyshev wrote:
>>> The previous patches reuse the source vhost FD on the destination,
>>> however both source and target still call vhost_dev_init() (VHOST_SET_OWNER)
>>> in realize().  For cpr-transfer the destination realizes while the source
>>> still owns the shared FD, so its SET_OWNER would fail - ownership has to be
>>> handed over explicitly.
>>>
>>> Do this through the device's CPR vmstate hooks.  Namely, release device
>>> ownership in pre_save, reclaim in post_load, re-acquire on restart:
>>>
>>>  - .pre_save() releases ownership on the source (VHOST_RESET_OWNER) once
>>>    the VM is stopped, for the FD-preserving CPR modes (cpr-transfer and
>>>    cpr-exec).
>>>
>>>  - .realize(), for an incoming CPR, only sets up the virtio device and
>>>    queries the backend features by calling vhost_dev_init_backend().
>>>    It doesn't take device ownership and doesn't touch the VQs which
>>>    still-running source might use.  The full init is deferred to
>>>    .post_load().
>>>
>>>  - .post_load() reclaims it on the destination: the full vhost_dev_init()
>>>    (VHOST_SET_OWNER) on the preserved FD, plus sets the guest cid, before
>>>    the device is started at vm_start.
>>>
>>>  - .set_status() refuses to start a device whose init hasn't completed
>>>    yet (incoming CPR before post_load).
>>>
>>>  - .set_status() re-acquires ownership before starting the device if
>>>    pre_save released it and this QEMU is about to run the guest again:
>>>    the migration failed, or it completed and the management resumed the
>>>    source (e.g. cpr-transfer target died).
>>>
>>> With the handoff in place, lift the CPR blocker.
>>>
>>> Note: this requires kernel side support of VHOST_RESET_OWNER operation
>>> for vhost-vsock.  Otherwise CPR attempt fails in .pre_save().
>>>
>>> Suggested-by: Dongli Zhang <dongli.zhang@oracle.com>
>>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>> hw/virtio/vhost-vsock.c         | 162 +++++++++++++++++++++++++++++++++-------
>>> include/hw/virtio/vhost-vsock.h |   2 +-
>>> 2 files changed, 134 insertions(+), 30 deletions(-)
>>
>> This LGTM and also fixes the issues in patch 9 IIUC, so IMHO it's better
>> to squash them. What is the advantage of having patch 9 changes in
>> another patch?
>>
>> Thanks,
>> Stefano
>
>IMHO having them separate is still better for a potential
>reader/reviewer to understand what's going on.  #9 only does the FD
>preservation + cleaning up the entry whenever it's closed.  And then #14
>is purely the ownership handoff.  I'd keep them separate, with
>amendments you pointed out to in #9, IYDM.

Sure, no objections on my side!

Thanks,
Stefano


