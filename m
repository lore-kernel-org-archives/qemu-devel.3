Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FFFCD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 10:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtm4r-000419-8r; Mon, 08 Apr 2024 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtm4o-00040p-Uv
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:18:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rtm4n-000269-Fq
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 06:18:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712571488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NDrdNvR/+rnwjtRFAlALhO1U3NBWgKRT9cit+qm6s3U=;
 b=RonUW3m94mnD/dvHKhM6ErZQKG/zUSJ53jC2/40NJLk382bOmfeqoSiyGryhECjqRXusgT
 oRQ0Kc+oRJVTTm8dZehNtgdExMUjH+quED6K/wHX01xrbVXql5DFnTaR9D2+bveOVyeOSz
 BuETXhvr2vwsSVgoTvtw5lxY0O1NZy8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-A2zkCMpDMDOhD1dPFO5GRA-1; Mon, 08 Apr 2024 06:18:04 -0400
X-MC-Unique: A2zkCMpDMDOhD1dPFO5GRA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-516be44ea1dso3703916e87.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 03:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712571483; x=1713176283;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NDrdNvR/+rnwjtRFAlALhO1U3NBWgKRT9cit+qm6s3U=;
 b=koKiyaUK+w2CAqa6dYD4PoqKvxXE+ACp8RPwbVP5g+E84WC8vPmv9PRNxqPYgGa805
 B0fcYrHAHtzkSDBof30HZ6hAti+J3CGChhX1MqqeJTBpCpc18ekXJfA+qKHdiXyInFkt
 SQAvjyM+FM9SMsDY7y6Jpp50Z3i4QmUMrTw1TUBcDQmu2j49gWoSU8pQIdMbgs5YNUUD
 4QzHPgl5t59oWAy80uIqKoTEhqt258jPIMfxTI0FVC2sXJ2sfecqq9vZfm7TUlv79hqB
 Sd0lD4G/Trx0F5GsWTk/3zqSjUo8khU8V0qmrzozKvpWggOIKT5a9GQ77NMtwSEAcszG
 T+vw==
X-Gm-Message-State: AOJu0YzugEzB4H97wyEH0CHTVsAEQEwhjXE3wAQg8pzWRGBQetJek6ER
 DmzqUMuACe3QRJygl5QaKMts/MQRYPWp/o/3cmvOn9uINHmrkGegm44VNosQ6Lrlp2thRE+Q/GJ
 scjbk4f8d0yC/gDA4OKUmxXBo7HvIwQIhnqGZJ3zM0l1Ic+MigxsR
X-Received: by 2002:ac2:5ddb:0:b0:516:d2eb:6edd with SMTP id
 x27-20020ac25ddb000000b00516d2eb6eddmr4970560lfq.26.1712571483003; 
 Mon, 08 Apr 2024 03:18:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsp1J22BTQ1qL+VVEmzbEGH404hkLoyWCTN4nc7qkafuD0FtR+TvcOYigGYeZkrX1pTLZGLw==
X-Received: by 2002:ac2:5ddb:0:b0:516:d2eb:6edd with SMTP id
 x27-20020ac25ddb000000b00516d2eb6eddmr4970545lfq.26.1712571482347; 
 Mon, 08 Apr 2024 03:18:02 -0700 (PDT)
Received: from redhat.com ([2.52.152.188]) by smtp.gmail.com with ESMTPSA id
 g14-20020a05600c4ece00b0041633f1513bsm9161244wmq.46.2024.04.08.03.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Apr 2024 03:18:01 -0700 (PDT)
Date: Mon, 8 Apr 2024 06:17:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] Revert "hw/virtio: Add support for VDPA network
 simulation devices"
Message-ID: <20240408061752-mutt-send-email-mst@kernel.org>
References: <df6b6b465753e754a19459e8cd61416548f89a42.1712569644.git.mst@redhat.com>
 <CAFEAcA9_mLQ=jWNEHBVLJKHST4X=QVdpgPCTh1mRSSiea7ruzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9_mLQ=jWNEHBVLJKHST4X=QVdpgPCTh1mRSSiea7ruzw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.355,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Apr 08, 2024 at 10:51:57AM +0100, Peter Maydell wrote:
> On Mon, 8 Apr 2024 at 10:48, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > This reverts commit cd341fd1ffded978b2aa0b5309b00be7c42e347c.
> >
> > The patch adds non-upstream code in
> > include/standard-headers/linux/virtio_pci.h
> > which would make maintainance harder.
> >
> > Revert for now.
> >
> > Suggested-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Are you intending to target this revert for 9.0 ?
> 
> -- PMM

Yes.


