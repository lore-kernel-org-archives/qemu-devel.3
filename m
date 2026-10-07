Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D70CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 19:17:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEX8Y-0002yG-6o; Wed, 07 Oct 2026 15:17:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEX8W-0002xo-FK
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:17:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEX8U-0005PU-M6
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 15:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791400624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4QvMRdtTpnS0X2N6Rn6LwYquh1JPn3T1UJPc55fggqQ=;
 b=JwtMgV5scYvFoVwsxBv2rvl8RMS7cq2FQs5a9h8A4yVAdh8EAz/y4vUyV9z2lbhXxbAQyo
 6WacwwPqGS1Ct9PniQNktH+T62dibyBjrlNHSZNZozNZ/ZdnK4RGglroQaanTyedBxYbA0
 RBNssRtjMB6OdR5OEyL4179xg1wt71E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-qARgndGCP_uoZSivkmgBiw-1; Wed, 07 Oct 2026 15:17:03 -0400
X-MC-Unique: qARgndGCP_uoZSivkmgBiw-1
X-Mimecast-MFC-AGG-ID: qARgndGCP_uoZSivkmgBiw_1791400623
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-91789a9107fso103435116d6.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 12:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791400623; x=1792005423; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4QvMRdtTpnS0X2N6Rn6LwYquh1JPn3T1UJPc55fggqQ=;
 b=A66WCb4Xz4CEBuGXOTKCGNhz7xHJ+kvZISCHKaS7zlVr1eosSJcQ+rK5wncInP9HNU
 l2lg6RbfeMDDqmVmb0AbRJzv4yY01TFmKOM4hDFQrMxXTOtmgw9PqHZJ14HewrX3RH7r
 mSCmbXUdRPX6LEhJ1unaOwG/Rg3ob9U09Fy+HIbiDE//LpPp6mtPlNVrCNsaPxpOLgXq
 G694pdExutBWK0QtbFUOlncYVcTqLcRDMkaOjip1WwzTRgb2FU87AI3Xb+lkmmHR4XbU
 UaM620EEF+FZOTJCCzDn/u+tewb2iLE/UZQsGiF8HrezWhLb3ruocmVogN+w5bgE5LoK
 /b7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791400623; x=1792005423;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4QvMRdtTpnS0X2N6Rn6LwYquh1JPn3T1UJPc55fggqQ=;
 b=bfiA5/yEnbntTCjnR4RVfMPBt0nV7RtATgDIZhrAJ4VqHJXbqvLthcI/a9aFB0iG+L
 LD3i4lKWEbyojUiixCEyuxMuBBh/AXiKCpcimKH9vwSpT8xPQfGxnOhlndQceaKQNKtI
 /UaMr3hZmEh9dkhoVWmQvigqus9lktioTgiDpTnh2vJwIC337DlM5wqwVbULAt/a5/tM
 avXhsrR1OU30karupGfCOjvSU2YYeMO/twlBJYnIdctkHvdBRlXbblEDtmLbP+YA69eB
 +KT3rvIOMNRkvab4fs7ai3LaPUGVj9fbY8+g5GqwaF05dV7tWvujB+psncx2vwmODjz8
 bhvQ==
X-Gm-Message-State: AFuF++micuzXKyCJoOfD37Tb+I8FDCfACQv0DQfD3ZBo7MeHYdwJrUFB
 unNG/IUbhGnT8sNMvH4GFXhMnjaq7u597DpvwS1L2h3UeO5sIvzLVMIb4lDKVehZjfTRit3hXjv
 /+Tgqa7uOQi3gI1ms2kKnMGiC4itibLeN7H0gQ3sA0qoGzp3guNW69bDh
X-Gm-Gg: AYBFou1Ilo3DP3lhBUggBLWx+b7Jbx5Qd/o7gwOIQ3hsXrALfu0+QRPJJvILoJBGCkf
 /La+AfW0rpUoxlSJEg0aW+tAJ9AnU/FbOQ+cTPLUHVCy1g6XcClwmrA06K1XT/05xnv4cIJrivZ
 FnGXB9nMgfJ9v5imDAlzfwtyHllsKw9EqQjDp2tGLkpxpOVLsiqlX5WsqEvsivSaT1NXIFhCecz
 jN7Bnq0roW2zGgWY3U4wuEUxcVDHU21n5HmEkeWAhqGGeSplAXdLijXXAZncT8jz6HqcSbRtG1v
 AVHvB6U6bt0YaB3RVy+/7NE9kSRBo7R/0Lmjp9G5Gj5zniVkRZ1VjnF/rcVPAQToTmROCSY=
X-Received: by 2002:a05:6214:5247:b0:914:4e89:132f with SMTP id
 6a1803df08f44-9199785b4ebmr55144446d6.31.1791400622672; 
 Wed, 07 Oct 2026 12:17:02 -0700 (PDT)
X-Received: by 2002:a05:6214:5247:b0:914:4e89:132f with SMTP id
 6a1803df08f44-9199785b4ebmr55143996d6.31.1791400622176; 
 Wed, 07 Oct 2026 12:17:02 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91996d52f41sm27299296d6.34.2026.10.07.12.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 12:17:00 -0700 (PDT)
Date: Wed, 7 Oct 2026 15:16:58 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 4/4] migration/postcopy: answer the package-loaded ping
 from the run BH
Message-ID: <asaaqsWyDWY57wo2@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20261002110258.1835979-1-den@openvz.org>
 <20261002110258.1835979-5-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261002110258.1835979-5-den@openvz.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Fri, Oct 02, 2026 at 01:02:58PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> Commit 7b842fe354c ("migration: Introduce POSTCOPY_DEVICE state") keeps
> the source in POSTCOPY_DEVICE until the destination answers the
> QEMU_VM_PING_PACKAGED_LOADED ping packaged right before
> CMD_POSTCOPY_RUN. The destination answers it from the generic
> MIG_CMD_PING handler as soon as it reads it, so the source's
> postcopy-active means the device state is loaded, not that the
> destination has left RUN_STATE_INMIGRATE. Management acting on the
> destination once the source reports postcopy-active can still race
> with loadvm_postcopy_handle_run_bh().
> 
> Record the ping in the MIG_CMD_PING handler instead of answering it,
> and send the pong at the end of the run BH, after the run state change.
> 
> The wire format is unchanged: the pong only arrives later, and an
> older destination keeps answering at once, so mixed versions
> interoperate. The cost is that the source stays in POSTCOPY_DEVICE for
> the duration of the run BH, including block layer activation when the
> destination autostarts.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Juraj Marcin <jmarcin@redhat.com>

The hope is this should work for Juraj's problem too,

https://lore.kernel.org/all/20260929132150.2215007-1-jmarcin@redhat.com/

If there is a repost, maybe worth mention it in commit log, but we can also
wait for more inputs.  This looks reasonable to me on its own,

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


