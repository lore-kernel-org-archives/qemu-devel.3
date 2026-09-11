Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450DBC79FA1
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:38:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4vpu-0005ju-Si; Fri, 11 Sep 2026 03:38:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vpp-0005ja-6i
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x4vpl-00012Z-OF
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 03:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789112284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yUhtOMunTON2415AoYz/2VPCrmYRFfs9Moehf4OQE6U=;
 b=inyZl8Mj/oLFyG2EkFdsu7trbK3CWSd6LYfVL2eIsOkHrAPSAEV1KDd+FjQrvoijgCgFgl
 eW7Xx8eDcWR6V1P2PEs+88q0vjRLv1t5MOrIt5rJd/73+CCT/Lg07oth7yi7QLrlVhZD3p
 +3NzJ9+O2Em3CLmRRCRlREuAXbvBq/w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-KGGH7FRwPcSNggjg4W1g1Q-1; Fri, 11 Sep 2026 03:38:00 -0400
X-MC-Unique: KGGH7FRwPcSNggjg4W1g1Q-1
X-Mimecast-MFC-AGG-ID: KGGH7FRwPcSNggjg4W1g1Q_1789112279
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so13824235e9.0
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 00:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789112279; x=1789717079; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yUhtOMunTON2415AoYz/2VPCrmYRFfs9Moehf4OQE6U=;
 b=jZsuA9TMhgC8eM9ujAIwdwka4hrhOOMSSY0g1pqrL6SVQmclJqqthIiLEs9GmaHp1T
 qj7X7oYgMv0M28LXPML7msT33PooO5RYgVvU3R6D0wR3NH/aQYuboEVy3JqM0YWKPxPz
 197O7I6AJyrN/Vol0O/tXm0DuXZtUzfbb5BhRVuy36V8VCpVbz/NYFyl/vV04T2hyE6b
 H2R4ZOBw+oaRb5uJskK5VtKY6njF6cn9ID5bwUN107+TeKjQhscHQYXiykDaSSqVzFE0
 gFERRpAr8AOt8IHr4fLefTxYwuYJXE+5F+NMhXzxDXtaz8CcB/XC0seJ2Nq9w3BBMnr6
 J7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789112279; x=1789717079;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yUhtOMunTON2415AoYz/2VPCrmYRFfs9Moehf4OQE6U=;
 b=AaMYycGXhGqtKiBQ/W3qVB1WU/P96JP9TH+Hcr6IOequ/IVj1bXT26uFL9bnrkNPzc
 KGAKvtTI8Fyeea24MHv23qtd4V86E8TcwI/HAKN/iCDTPOPsvU4Hr0IF5dt9WY1SevYT
 hWEjR3zN3QRDh/KZprU3le9xsMxX13MG9x9q63DAFOVfMxxuVrSBVRstvIjPbdPsUeFu
 S5e29Fq+avz+yQ+AOCH/v+8Pl5J8qG9gfoMtFQF9G8k0BScI0UUA5bVrgHdhxe39DLVy
 HOvPNq48dZ9ufSVBD/C9HJJCc1HYJPcG8ereG/cV2qBrpUQ7m/GP4O3g+bRwrJ1mrOJd
 3C9Q==
X-Gm-Message-State: AFuF++msqP1KQ8s7wefMKuEFPcVOjtEzvIfmGzgIxmgziejC9t6CZRs5
 GaaxMI4rvRIlblvHpz2j+pwioJtUFca0YwM6o6AY06KBZpruzWtUy+n8t4Una3Ewtxun0V9RtzG
 obQ/Yc8GyLqw38QhQUpOkjpaxPIxOTnUrTxYTZMbHlLT3NJjWjqhMwPbU
X-Gm-Gg: AYBFou3VV88ThTMk6fiSh0vzj10WcXl/1TCC9rmDGv1mQ7BzsfLEPRDx7t9vdBh+GDa
 buwZ4g8aNSSpaxnNussToi8rwiZDA6Z8Yy71AfZnSCI2wejyXEKqEl+6SOpTYm6CrsR8ICqpM3p
 eYkQ5hKPUf9PUUcmvfk4yKBnKccLWudQU7+8rGN1nl06DUwtB3OW5cx6UWRK5ba9Iz105vDz1Sb
 EIpqYmpGUWg4MilKVSGGxexMSL0JsG3jRkiYCTCOI3pxQdWpf2jHFt53tRB3AgdZLzAnPgC/VO4
 7SaxFYYZqAm3ls1/Vde3Qnh3b5mwHspvW7eRF1WbuwKRw+tmRzzhsLYO0TDgJLepZE5kWHNZOrI
 1CVxoKaz00EzTZo1r+TekLDbG3agKbvMpHhMnlYB+pSfwew==
X-Received: by 2002:a05:600c:19cb:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49e658188e3mr12466375e9.2.1789112279160; 
 Fri, 11 Sep 2026 00:37:59 -0700 (PDT)
X-Received: by 2002:a05:600c:19cb:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-49e658188e3mr12465835e9.2.1789112278580; 
 Fri, 11 Sep 2026 00:37:58 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e6221963dsm26309245e9.2.2026.09.11.00.37.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 00:37:57 -0700 (PDT)
Date: Fri, 11 Sep 2026 09:37:38 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, farosas@suse.de, 
 peterx@redhat.com, dongli.zhang@oracle.com, maciej.szmigiero@oracle.com, 
 bchaney@akamai.com, mark.kanda@oracle.com, den@openvz.org
Subject: Re: [PATCH v4 05/10] vhost-vsock: preserve vhost FD during CPR
Message-ID: <aqOu-wrcPrqSpHl0@sgarzare-redhat>
References: <20260820113955.509478-1-andrey.drobyshev@virtuozzo.com>
 <20260820113955.509478-6-andrey.drobyshev@virtuozzo.com>
 <ap7Gc_L0gYkAaZiV@sgarzare-redhat>
 <fc5bf943-68d3-4768-bf9e-cef14c81a0e4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <fc5bf943-68d3-4768-bf9e-cef14c81a0e4@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 09, 2026 at 07:59:55PM +0300, Andrey Drobyshev wrote:
>On 9/7/26 5:55 PM, Stefano Garzarella wrote:
>> On Thu, Aug 20, 2026 at 02:39:50PM +0300, Andrey Drobyshev wrote:
>>> During CPR (checkpoint-restore) migration the guest keeps running on the
>>> same host, so instead of reopening /dev/vhost-vsock on the destination,
>>> we should reuse the FD from the source.  The FD is saved in the CPR
>>> namespace (hash table) with cpr_save_fd() and then reclaimed on the
>>> target via cpr_find_fd().
>>>
>>> Since the key in CPR hash table is device ID, CPR needs a unique ID.
>>
>> mm, are we sure the device ID is unique?
>>
>> I just tried this whitout receiving any error:
>> qemu-system-x86_64 -smp 2 -M q35,accel=kvm,memory-backend=vsock0 \
>>      -object memory-backend-memfd,id=vsock0,size=512M \
>>      -device vhost-vsock-pci,id=vsock0,guest-cid=3
>>
>> Stefano
>You're right, that seems to be the a real issue.  In fact there's even a
>UAF bug IIUC, stemming from the fact that we: 1) provide key destroy
>function when creating the CPR hash table; 2) use same CprFd for both
>key and value.
>
>That means that when we have several devices supporting CPR with
>repeating IDs, we do:
>
>  g_hash_table_insert(table, fd1, fd1);    // table has fd1 -> fd1
>  g_hash_table_insert(table, fd2, fd2);    // table has fd1 -> fd2
>
>Here fd1 and fd2 have same hash of course. According to GLib docs [1],
>value is renewed in this case, but the new key is destroyed and the old
>one is used.  As a result, fd2 is freed.
>
>And, mind you, this all happens long before actual CPR, cause the
>devices with CPR support usually call cpr_save_fd() somewhere in
>.realize().  Thus we get memory corruption right at boot time, plus
>subsequent CPR will likely crash.
>
>In these circumstances I'd personally prefer just asserting on repeating
>key somewhere in cpr_fd_hash_insert().  The only downside is that it'll
>crash when booting 2 CPR supporting devices having identical IDs, even
>if the user isn't going to perform CPR.  I'd say it's acceptable, what
>do you think?

I'd prefer an error if possible.

That said, can we append a prefix to the key (e.g. `vhost-vsock`)?
In this way we reduce the chance to have a conflict. Of course the user 
can still assign `vhost-vsock-something` to the memory backend and 
`something` to the vhost-vsock device, but yeah xD

Thanks,
Stefano


