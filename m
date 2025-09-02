Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB370CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNfx-00019t-FD; Tue, 02 Sep 2025 05:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1utNfv-00018w-IU
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1utNfs-0003mp-Sc
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756806693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uoCGDKlTbB7Uqa4JWXzho1CgR/huD3BcI+EdTRmk2wc=;
 b=ev5yj1vHzC3o0SCqMZYS50+Dl/GzqL0PvHI7hNZithZT1lsZEpri5+Cl/St3ZuRk9BBWLV
 xukE/07QPO174fBBzcbumtvrGbgGZlxjq5Ehq1BnObohv0hN32I1lG5lLA934LUcgXqoYD
 de3g8cE1YGanB107S1hMju9zZElM1T8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-q2qq_CHgPcCDPRJym47DTw-1; Tue, 02 Sep 2025 05:51:32 -0400
X-MC-Unique: q2qq_CHgPcCDPRJym47DTw-1
X-Mimecast-MFC-AGG-ID: q2qq_CHgPcCDPRJym47DTw_1756806691
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b467f5173so49238045e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:51:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756806691; x=1757411491;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uoCGDKlTbB7Uqa4JWXzho1CgR/huD3BcI+EdTRmk2wc=;
 b=f60pzoXOv7sAh7T3hTKW7KX1+/kWu8VlwvkbffEf/M5zdHhrnpoV62XwLXO94Dojwc
 TYoZu/5hskurURcreyQlu8YFYDPppYmL8ZzLON3zwIa0n7CuoPFAB9QlyL6wtBt4ZFTc
 Lmxu7DW6hW4/24AB0BMD7yZAYAv35551mvT9JgR3/z8+1tWl4W1i2xBx6pUBea5j0JUv
 FfoAqQ57m4fcBjgwZMU0A5Ni+9gyw6qyCE+P8XVpPaAUJKbnwEw1kl89bigVVzF+nXT1
 a19EBqmn468K9UsNrc4saJlGETURZHx9hyrYAyr8cCTOHqxIfaKda/z6L7l+8AgFfHVd
 5uyQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQoAjU09QvDiu1fMwr8L9Ovfk55ZhhfxmaptSD5mRehQYZcfJb3p3klmL90cvUhUYoFaP12yTlkFMB@nongnu.org
X-Gm-Message-State: AOJu0YxSXh+83KghFxZR7DTP9baIHF7zuFq7DyztqHY6LQnnnTMldi/f
 WiR0s/0dK+xY2QLzf3f2h2J4xYF8dpXd46Xvmy42a308tGQblU+eQKVUdm89CpHcVQASPZTJfRQ
 7VyvMSBJvS91uifZPUCjf8GuNqPsJd2xwWk/KSfcQggYpdLoGPhY6D/zR
X-Gm-Gg: ASbGncuPFIDQHLFOBCDn8Z0bZZT1Hyzy6VoO97vsHeVGQK8RJTGrGtS3EsRqs7IYYHU
 m6M1+kdYdccb2pF2s8FDziWP1XduQfXBP4SXY3rqE63sESD9uwpGrMEdmrTI+FZPAhVH4VcZJjL
 8+byvbJ208wKT/IFqbZZBcOsHs2M/DB9kYl+aRp8vKTt//3uMPVxCpRtwQ/+sppytgewzrAnCFp
 V6onXtt38cYj+SNRPpw1QIRsrQrbgArh6OFwlT00vn8UfPPlJKzK9Vy9jN8fwsYX2fJadMJMDHt
 vZ74FsJXj/0nsphQD9WokVBDFHijHSNH5Q==
X-Received: by 2002:a05:600c:c4a1:b0:45b:84b1:f638 with SMTP id
 5b1f17b1804b1-45b8559babbmr73690395e9.20.1756806690585; 
 Tue, 02 Sep 2025 02:51:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCStOLKPpP1Se+pkvTNG7Na4Yhq/Es/szPp6pyKC0/eTT5yjYxpQCNwXZW5872oxKkTUBxog==
X-Received: by 2002:a05:600c:c4a1:b0:45b:84b1:f638 with SMTP id
 5b1f17b1804b1-45b8559babbmr73690135e9.20.1756806690090; 
 Tue, 02 Sep 2025 02:51:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1524:4900:335a:c45c:daa9:7d75])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b8525a94bsm142930845e9.15.2025.09.02.02.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Sep 2025 02:51:29 -0700 (PDT)
Date: Tue, 2 Sep 2025 05:51:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH v5 00/13] virtio: introduce support for GSO over UDP tunnel
Message-ID: <20250902055046-mutt-send-email-mst@kernel.org>
References: <cover.1755080613.git.pabeni@redhat.com>
 <3590d748-752c-40f5-92c9-5c065dcc3c0b@rsg.ci.i.u-tokyo.ac.jp>
 <CACGkMEvOmgGyqv5-FGDAgyDrY9TpssEDtpNp07ro2oamg_7r1w@mail.gmail.com>
 <8c41ea67-c5a3-4f16-85a2-cc4876f09995@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c41ea67-c5a3-4f16-85a2-cc4876f09995@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Mon, Sep 01, 2025 at 08:44:46AM +0200, Paolo Abeni wrote:
> On 9/1/25 4:47 AM, Jason Wang wrote:
> > On Thu, Aug 28, 2025 at 9:47 AM Akihiko Odaki
> > <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
> >>
> >> On 2025/08/13 19:28, Paolo Abeni wrote:
> >>> Some virtualized deployments use UDP tunnel pervasively and are impacted
> >>> negatively by the lack of GSO support for such kind of traffic in the
> >>> virtual NIC driver.
> >>>
> >>> The virtio_net specification recently introduced support for GSO over
> >>> UDP tunnel, and the kernel side of the implementation has been merged
> >>> into the net-next tree; this series updates the virtio implementation to
> >>> support such a feature.
> >>>
> >>> Currently the qemu virtio support limits the feature space to 64 bits,
> >>> while the virtio specification allows for a larger number of features.
> >>> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> >>> 65-69; the larger part of this series (patches 4-12) actually deals with
> >>> extending the features space.
> >>>
> >>> The extended features are carried by fixed size uint64_t arrays,
> >>> bringing the current maximum features number to 128.
> >>>
> >>> The patches use some syntactic sugar to try to minimize the otherwise
> >>> very large code churn. Specifically the extended features are boundled
> >>> in an union with 'legacy' features definition, allowing no changes in
> >>> the virtio devices not needing the extended features set.
> >>>
> >>> The actual offload implementation is in patches 13 and 14 and boils down
> >>> to propagating the new offload to the tun devices and the vhost backend.
> >>>
> >>> Patch 1 is a small pre-req refactor that ideally could enter the
> >>> tree separately; it's presented here in the same series to help
> >>> reviewers more easily getting the full picture, patch 2 updates to
> >>> linux headers update script to deal with annotations recently introduce
> >>> in the kernel and patch 3 is a needed linux headers update.
> >>>
> >>> Tested with basic stream transfer with all the possible permutations of
> >>> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support,
> >>> vs snapshots creation and restore and vs migration.
> >>>
> >>> The new features are disabled by default to avoid compatibilty issues.
> >>> They could be enabled after that hw_compat_10_1 will be added, together
> >>> with the related compatiblity entries.
> >>>
> >>> Based-on: 9d71108d7de139dd4f4e6efe6837cabb32bf5616.1755078918.git.pabeni@redhat.com
> >>
> >> Now everything looks good to me. For the whole series:
> >>
> >> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>
> >> Regards,
> >> Akihiko Odaki
> >>
> > 
> > Acked-by: Jason Wang <jasowang@redhat.com>
> 
> Thank you for the feedback. I guess this series will go through
> Micheal's tree, am I correct?
> 
> Also I suspect/fear it could need rebasing due to some other patches
> being applied meanwhile, please LMK if a repost is needed, thanks!
> 
> Paolo

Yes - I am however traveling for the KVM forum. Will work on it
when I am back.


