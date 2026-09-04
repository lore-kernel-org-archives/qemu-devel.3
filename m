Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C30AEC624D3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 13:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UNA-0000yp-Cr; Fri, 04 Sep 2026 09:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2UN8-0000yT-2V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:54:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2UN6-0006Lo-3n
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 09:54:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788530062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uB8EEV9LjU2BlLZ6wymXQDBlF2TAqKBYlSiYeMs/1NY=;
 b=MX36i7KdRoUi+23mojGMVUPpa/hHH8du3Ef95RXzbeY2G8oWdHbFmTxT+pwWeyC73btA7r
 v4HjothN7hkQmsyjpnpy4W/Ph1i9YWn3T8pJUIPRTaPG9oaPzA95K0wy9fYGxwSUDKf18d
 iIj9UyJRwwdkW8LQ+oFpp45TuVsTz8w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-H2doyHhfM1eow91d55HT0w-1; Fri, 04 Sep 2026 09:54:21 -0400
X-MC-Unique: H2doyHhfM1eow91d55HT0w-1
X-Mimecast-MFC-AGG-ID: H2doyHhfM1eow91d55HT0w_1788530061
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-939665a1ae6so256426185a.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 06:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788530061; x=1789134861; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uB8EEV9LjU2BlLZ6wymXQDBlF2TAqKBYlSiYeMs/1NY=;
 b=ddSJt9/FnSR7ygicRU2EmsLLC5TMyZak2cEMLVpLmq0UJpx88+4ExUo5eM4ySqptCl
 u/1JGcVuwC8/egEVHxu/AYftTOR+zPSJWGBHUiz4gel4TXRc6WQpkR6s9wtwUSm0mPqs
 pQl3JOtZrmb5o1zNeUgD7yhrfb7zH6lRJN8913xYNXsz76C2ymy00cY0NC9csH4xu/jd
 z0Fw+MaJiGmBTP8/A9MMNBNH3QmotaB5jt8O1W61VPWVuR03sJpG2YayNPGyq0iT+nNY
 a1ZuGsBZWuF8pw/3+LhDTvLtCEMmLiTXdd+CbhwWwVMFJF/GVVo/dZDDuIMVMKMOzzQJ
 CWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788530061; x=1789134861;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uB8EEV9LjU2BlLZ6wymXQDBlF2TAqKBYlSiYeMs/1NY=;
 b=hw6AE1uSpt7rLuv7NLLJcq+Zw+CX8LmydEt1oNY0PPjbA20/HHkx4n2p47rYtvgEun
 DJeNIdBqaaLkLRFQvaDprMcg2OYKQPz2g7MjxZzO/yQ0L/jPe/9Jyx3MuPyZjpvaqUoh
 7D237nx6XsuzyynlJbZJDCPF4lTXGnroLA5r0B3pcCyDun1R6I/eGbbGt2x0M2Z5qNJa
 yY/Z37Gp4ur9CbDwO6fqdtAQloHFurjVDnnofI1Qfy5nsLiq8724gPUK3yER1jHjOS5Y
 ntIUFiW6Eycu9N/++aIxYvSHdR5X1qvzBqkSEK4Ts1NRCdYsdWCFSQXZyITblw9frWxV
 zQFA==
X-Gm-Message-State: AFuF++kCwHlSy7vh8DAE68r9kyqvI0OeH5EZSxWQxVWOar04JUM1s5vm
 tzwEIkUdG9CXwexwzAhZH2S5W//+M9kFNNV7M9NiH+ABqCKJKxdvhTQf7972yRGPVjyRs6ep/CW
 /lHInH9BNBBTKBM05rsU6xQrb6TNY3wYB8FymxfaaZtbXYpe2LHs5IMgt
X-Gm-Gg: AYBFou0EmH+10EkIu3Ul1a9U1AOk75q6AaEfqOvCDTcanT7SIOYsPZRhJ6liGwrlMMd
 wVbsYHXRWfbKx3P/DmkicLzJNN/WZa/L0LWAtHHGB8WLeLV6+KGlXhuFTdKYzQ/nV8IRH41fC6E
 4lo3QEV5bVpCCzzLo4EkwFPbsMB3XPPPnHmL477gib+qAsbpgfv+VYHZI/oh2vXTFpNcIIohUP/
 kU8v2Vkf9UcXVDz4BlitYguuT0mcWO6jhKaEMrmPPeBM2oJvjuRNjPk9hbqBDOAFFcKL9if8cHX
 SRvTUu3ZmOTWSmwhJ+qm0MbNvWnAicCIL/Vq0R6Q/ZWSRbiBuDNMKBC3wbbubIL48ua8UVo1
X-Received: by 2002:a05:620a:a019:b0:937:50b6:4a5b with SMTP id
 af79cd13be357-9398038c4dcmr555664385a.23.1788530060768; 
 Fri, 04 Sep 2026 06:54:20 -0700 (PDT)
X-Received: by 2002:a05:620a:a019:b0:937:50b6:4a5b with SMTP id
 af79cd13be357-9398038c4dcmr555659485a.23.1788530060173; 
 Fri, 04 Sep 2026 06:54:20 -0700 (PDT)
Received: from localhost ([2605:8d80:6d61:1b95:5d7e:c15d:7429:70fd])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb303b8sm228681285a.20.2026.09.04.06.54.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 06:54:19 -0700 (PDT)
Date: Fri, 4 Sep 2026 09:54:17 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] migration: Drop iochannel reference during snapshot
 setup
Message-ID: <aprNif-4MLKwW421@x1.local>
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260903220523.2849019-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Sep 03, 2026 at 07:05:22PM -0300, Fabiano Rosas wrote:
> During migration there are usually two references to the iochannel,
> one from the channel creation itself and another from the ownership
> transfer into QEMUFile.
> 
> - The reference from the QEMUFile is decremented at qemu_fclose.
> 
> - The original reference is decremented at migration_connect_outgoing()
> for regular migration and not at all for snapshots.
> 
> The ide-test has recently added migration support and ASAN has
> flagged:
> 
> Indirect leak of 32 byte(s) in 1 object(s) allocated from:
>     #0 0x55ca12aac0b9 in realloc
>     #1 0x7fd97d7e5a05 in g_realloc
>     #3 0x7fd97d7c98c6 in g_hash_table_new_full
>     #4 0x55ca14e186f1 in object_initialize_with_type ../qom/object.c:506:23
>     #5 0x55ca14e1a590 in object_new_with_type ../qom/object.c:706:5
>     #6 0x55ca14e1a7e8 in object_new ../qom/object.c:722:12
>     #7 0x55ca12de896f in qio_channel_block_new ../migration/channel-block.c:32:29
>     #8 0x55ca12ec8f2d in qemu_fopen_bdrv ../migration/savevm.c:172:49
>     #9 0x55ca12ec8b42 in save_snapshot ../migration/savevm.c:3375:9
>     #10 0x55ca12ee18e3 in hmp_savevm ../migration/migration-hmp-cmds.c:497:5
> 
> Change qemu_fopen_bdrv() to drop the original reference once the
> QEMUFile has taken over the object. The xen code already does the
> same.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


