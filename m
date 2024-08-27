Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D49BC54736
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 20:56:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sj3E7-0002yH-EI; Tue, 27 Aug 2024 16:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sj3E5-0002wy-Cy
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:55:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sj3E3-0003VM-Ng
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 16:55:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724792137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IQ9DTc8Zj5L93/tzQbCYNIQkmETuh0e9n6H2ngdt6nA=;
 b=LzvrKyoZ00K7Ashz3yZC/oJbQBMrNNf8e9O5RDj+ulQIreGVMdAk/NNKEpoNhFC4bHz8LZ
 ulUOmP2Ck9ey27fAgPgHEHPCPk3eMRk8WmoZq4NIHDtWYq1X9kEca28XXSKLe/NdIA1zRI
 I3IwF4QA8sKPwadI2ocKuFgomqj2V10=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157--bpEGolDMGWNo9DNfVZJ0A-1; Tue, 27 Aug 2024 16:55:35 -0400
X-MC-Unique: -bpEGolDMGWNo9DNfVZJ0A-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a80ebde3f94so495151166b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 13:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724792134; x=1725396934;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ9DTc8Zj5L93/tzQbCYNIQkmETuh0e9n6H2ngdt6nA=;
 b=ZIUflb/ZdxUmmLfqIhDLM4/tmGgsFNc9BwGzkVbQlUgtmLO/CNOCuigRq7eG1yk9re
 4VTUL8S/1W1Mqqy/8+7eb2SHHedbiIOGJh52dLRTRFK1YCGE/M113UuOyGbWmq9UNTGi
 rkXfcVr+wmG/sVJIxAnoSBY0M2ENPdb0sqOmGcWGsSHVCcZtUw/KAh5iXmsEXRJmy26L
 /SKNjvuZkmUPdg6qFvd1uQTSNtFLDrlSeF1qSII+Ig+McFXpEl4HfK0Dwit4syXy58HQ
 WVoqb6XQxg2DHr0fpOsYw5Qbkg3I95p4lr9tc3oTZ8chPUAjxOkagW0hCGSwF2LLF1On
 r44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjQnB2eUk8lDeHcVJrMlIW/CLxkOaR6oOxRGsS3O0rIIcVE0fLnRkyrCT3rLmUa4JRMz8dyUb6zZjn@nongnu.org
X-Gm-Message-State: AOJu0YzdcBwrR54R7FL5L3XZhl47lEGfyJyUidBCJJxrrHThoqGQkvMD
 UnHSbVdCYT2WEMiL6hLmPg6Y3eNST22ilC51NGQ5Nvf8emYDPPKI0B8MbkG2EalmkeMUtX8JTY3
 I5ou1XAyynv0Vc5BLFmGoz5oqZ7cqPyzTwTzQxXCLVM+S+beFJ9qZ
X-Received: by 2002:a17:907:1c1f:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a86a52c11cfmr938469566b.32.1724792133920; 
 Tue, 27 Aug 2024 13:55:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHY3OCdb5G7p0KMorpKvXXc9UhB0DGo//+Yh614VXYPlDmq/vKvwJrpmgYTvoK1V53WFNJs2w==
X-Received: by 2002:a17:907:1c1f:b0:a7a:a960:99ee with SMTP id
 a640c23a62f3a-a86a52c11cfmr938466866b.32.1724792133153; 
 Tue, 27 Aug 2024 13:55:33 -0700 (PDT)
Received: from redhat.com ([2.55.185.222]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e590a6f2sm151681966b.188.2024.08.27.13.55.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 13:55:32 -0700 (PDT)
Date: Tue, 27 Aug 2024 16:55:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: BillXiang <xiangwencheng@dayudpu.com>
Cc: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3] vhost-user: Do not wait for reply for not sent
 VHOST_USER_SET_LOG_BASE
Message-ID: <20240827142324-mutt-send-email-mst@kernel.org>
References: <20240801124540.38774-1-xiangwencheng@dayudpu.com>
 <20240801101210-mutt-send-email-mst@kernel.org>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.d4485eba.82f2.4fda.af98.6cd4ae867655@feishu.cn>
 <CAE8KmOxPS2QsWOesKg7h_euSV7r-z4NPZ9vMvTLY6tOudqJjuA@mail.gmail.com>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.aef11064.252c.4e66.b54f.0729a2c3aa1c@feishu.cn>
 <CAE8KmOz1QH_gT=nOvovqTj+th=uMxEvacGxN4ndTYwz=dPxrHg@mail.gmail.com>
 <fba0cfc406f202976ef5ac5d129e08524ce06bbf.a3d7ed0c.8388.4f30.8938.ed24afc64c52@feishu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fba0cfc406f202976ef5ac5d129e08524ce06bbf.a3d7ed0c.8388.4f30.8938.ed24afc64c52@feishu.cn>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Aug 27, 2024 at 09:00:35PM +0800, BillXiang wrote:
> 
> > From: "Prasad Pandit"<ppandit@redhat.com>
> > Date:  Tue, Aug 27, 2024, 20:37
> > Subject:  Re: [PATCH v3] vhost-user: Do not wait for reply for not sent VHOST_USER_SET_LOG_BASE
> > To: "BillXiang"<xiangwencheng@dayudpu.com>
> > Cc: "Michael S. Tsirkin"<mst@redhat.com>, <qemu-devel@nongnu.org>
> > On Tue, 27 Aug 2024 at 16:50, BillXiang <xiangwencheng@dayudpu.com> wrote:
> > > it's better to be consistent to use vhost_user_per_device_request for those per-device messages, right?
> > 
> > * ...consistent to use? Could you please elaborate a little?
> > 
> > Thank you.
> > ---
> >   - Prasad
> 
> That was elaborated in commit b931bfbf0429 (" vhost-user: add multiple queue support "). 
> We have added vhost_user_one_time_request() to send those per-device messages only once 
> for multi-queue device. Which was then changed to vhost_user_per_device_request() in 
> commit 0dcb4172f2ce ("vhost-user: Change one_time to per_device request").
> And VHOST_USER_SET_LOG_BASE should be one of those per-device messages that only
> be sent once for multi-queue device.

Bill,
it's important to make it clear, in the commit message, what is the
current behaviour and what is the effect of the patch.
For example: currently qemu hangs waiting for ...., to fix,
.... so we never wait for .... .
At the moment, I'm not really sure if this is a bugfix, or
a cleanup, or what.


-- 
MST


