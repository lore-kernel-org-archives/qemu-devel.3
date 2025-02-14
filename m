Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95700C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 16:53:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiyvu-000615-N1; Fri, 14 Feb 2025 11:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiyvs-00060q-7D
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:52:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvaralar@redhat.com>)
 id 1tiyvq-0005WK-8K
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 11:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739551968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6+D/ZfZ1IQfK2X5Rxvx/iJxWcgVJK31ghlhCyWWZrqM=;
 b=GIwuyssPn0rajoDS8YhVJKL8VtTgBTn36czlRQXf0J0eyobVLxRRDzcw7f0b4R0xSg83Rp
 E+DhAt0bqEMYD69CWROKHxGIee4Xqzd4t59bsrXnyUOPFet7qcc0nOYyRK/SlpdnjAMO6F
 PnTmPMF9jryioep1+b3x2GyfXIDkfyM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647-BHNtqEaENfKBaiKFicTRhQ-1; Fri, 14 Feb 2025 11:52:45 -0500
X-MC-Unique: BHNtqEaENfKBaiKFicTRhQ-1
X-Mimecast-MFC-AGG-ID: BHNtqEaENfKBaiKFicTRhQ_1739551964
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-38de1e83c97so1558490f8f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 08:52:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739551964; x=1740156764;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6+D/ZfZ1IQfK2X5Rxvx/iJxWcgVJK31ghlhCyWWZrqM=;
 b=EwvYjbJivvDQDyGpC4ndCHj2H7+nnPFSvLq3JS4XMf3A+eChlo02BjNcqdSKbtrX5p
 lM7pzmcYVjtTjLg/pdBYBvA3ZUIbcJqAunDTxD4VGQKf8+6gdJyMHNNRjmQ5YBGVKPGd
 S4DVLNUCqCIxqSrcR2cLCOb1uJBPbCk++VOpNSulEWqVn/G1pF58AJb8Ul2//vBRTXDZ
 PLNMrnrNltdifECtQmxiN/31/byWxu1mvEFFE7gznIhfMGNnVaHfyoe015uyWGO6Q5vR
 cSBJXQCdOyKz0DqPkSx7AGjZxUDYfWvvrR79gaEVbo2ZPnBjKrytCMLynaJoQbQIa8o3
 QZBA==
X-Gm-Message-State: AOJu0YydEWjppzlXRnRLTzgiJZ/5Cxw0Qnh9Frqzs7wdhqKnh7xwe2Gq
 x4E2tSoICxqvrN3vVxFfT94wq+y+3vlYIbfpKm4jfuXxX72JdQAUFNOkZboGjaox88eMo7krM6B
 MIJ3rKjiGtAm3jFcKjKe5yVCMfzqfdn4b/fvrfkbKYHtHituSFi6o
X-Gm-Gg: ASbGncvNDTzSPHnPsgBUaSIrC5iMRZZWD/if7JcgbFkBtl2iZs4RnBdw3J0DchZIMio
 yERPb3QBbrNWO+zFSUIanMq/5K1Qn/hcLZD04M8nD34DMKWGL4fcbdcFmsijey9lwzQrHPje8uL
 kvr8wGjaqjdFpZxPj7z8Kc9n3T6+e6mHFpW2zzTRaMZyqtIrrWJhbgxLoteBqfOCzASt/3Lasbd
 LpvPtCvSDuY3sL0f+uNfwm21UaPFK6k5THyg4mnzhpocYWWG7J7xls3in1YjkXQcywZ9yXH
X-Received: by 2002:a05:6000:2ce:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-38f277a5263mr9816325f8f.0.1739551964000; 
 Fri, 14 Feb 2025 08:52:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFwhRIXYTHxtvCtjXWGAhf6t42a0RSAQp1TotBNKLZUi89X4DRtNlM3XqrP4l6uHym/yvNTrQ==
X-Received: by 2002:a05:6000:2ce:b0:38f:277a:4eb6 with SMTP id
 ffacd0b85a97d-38f277a5263mr9816288f8f.0.1739551963576; 
 Fri, 14 Feb 2025 08:52:43 -0800 (PST)
Received: from fedora ([37.166.73.236]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259d5b40sm5109178f8f.68.2025.02.14.08.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 08:52:42 -0800 (PST)
Date: Fri, 14 Feb 2025 17:52:40 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: Re: [PATCH] vhost-user-snd: Use virtio_get_config_size()
Message-ID: <Z6902FScUnRi9Crz@fedora>
References: <20250213132513.767709-1-mvaralar@redhat.com>
 <bc05ff1c-94ce-4877-9b8f-9fb909cd67a3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bc05ff1c-94ce-4877-9b8f-9fb909cd67a3@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mvaralar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Feb 13, 2025 at 04:07:47PM +0100, Philippe Mathieu-Daudé wrote:
> On 13/2/25 14:25, Matias Ezequiel Vara Larsen wrote:
> > Use virtio_get_config_size() rather than sizeof(struct
> > virtio_snd_config) for the config_size in the vhost-user-snd frontend.
> > The frontend shall rely on device features for the size of the device
> > configuration space. This fixes an issue introduced by commit ab0c7fb2
> > in which the optional field `control` is added to the virtio_snd_config
> > structure. This breaks vhost-user-device backends that do not implement
> > the `controls` field.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2805
> > Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> > Signed-off-by: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
> > ---
> >   hw/virtio/vhost-user-snd.c | 18 +++++++++++++++++-
> >   1 file changed, 17 insertions(+), 1 deletion(-)
> 
> ¡¡Bien ahí!!
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Thanks! ;)


