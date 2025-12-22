Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746FCE6B257
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Dec 2025 22:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXoAt-0000aP-QV; Mon, 22 Dec 2025 17:14:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vXoAr-0000aB-Fj
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:14:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vXoAp-0001JY-KO
 for qemu-devel@nongnu.org; Mon, 22 Dec 2025 17:14:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766441677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VdDah+FTcesxnqhq/VXv7lASDIDBFpQeVroyQLMyI3Y=;
 b=UqKbggbvNC8gXxUIRP6DAohurUN7kFoeBAJiKwWnKDAOGzW+yAme32Pb3ZwSz1mxBlZkvb
 TVx0IigUKZTjUDv60Vyu00NxH1YNveLxTHA3HUMT/lXpjskFultzgFQYArndYq8yMd6AE0
 2/FnQ/oKId3kE7PquBfuqUJubRlHa30=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Sa8oAXOjPNqWnzjk6cHWbw-1; Mon, 22 Dec 2025 17:14:35 -0500
X-MC-Unique: Sa8oAXOjPNqWnzjk6cHWbw-1
X-Mimecast-MFC-AGG-ID: Sa8oAXOjPNqWnzjk6cHWbw_1766441675
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47788165c97so24850525e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Dec 2025 14:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766441675; x=1767046475; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VdDah+FTcesxnqhq/VXv7lASDIDBFpQeVroyQLMyI3Y=;
 b=LMs5wUwokFPdvNM/62jaWVkdggSQny3Vn7naAuZ9OD+UTtoDGtPWQRDaf0+CGnowh5
 erHqHQkABgYsVNBrZw1D1BZNy5sOKsy829bRR3BA8ypS/iajH50GkCUELygBoX30k5Pv
 e/JQB38pk8pbkwjDI7/8czQn+TGKxuvggJnP8+yAsKNC8+JmVrkn/ko+WqFu1YKovrap
 7tCqbmPLh0wz34IyirU9J9kqtdNjpJr6T1JEYuybg5oM3oFoI6mYv1xt/ylyxCAYxZMf
 j+OV65e8H59zFIiqogOLhElmybofZXhgaQbDLfTOusLX72xHz3GPbXShJMrBC8Eqh4Ss
 tqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766441675; x=1767046475;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VdDah+FTcesxnqhq/VXv7lASDIDBFpQeVroyQLMyI3Y=;
 b=b9ZFvb6a+D2TPlixHqoHQd29aZCprTlix8bHTCRPfmKveh6vKgslMd3wm5mT/b3XTU
 Bl6iDISeVKFvvSN2gtmF3/hFK7ylQxelZbLgCflo862i1WtAa7zmNRBQ1qA48r+j070T
 RAZtCTJB67YVOLR7XNLUpGgLUnyiEPmxL8JSt4L/wglcQUmGgt1ZceG2OeGizVPYfNz8
 VyvJdfY6lfGus1PgP5+HiBT0Co1qjxE6WE5/BGj6hC7hjG5ri0Hj26pFjBsSdHAm59wH
 0MsGXjmcdvlZ+VEAVK9p0x8z0OpPBt+6IYHD1xVDx37Lyzv/jtYCmu/Y17bP2/IChjAC
 mHkQ==
X-Gm-Message-State: AOJu0YzYNaasoMuC1inRQORhfC1p1R9miUGmD3XkSucpjs1CgfeIk/sz
 J/E44qqIIl8037wNloV/IIRH2WT+AGj/YfVVUidzH1oErss5CX6bl/tdCNxvWHoLN39fovSf0fx
 t/HmQsWk/YI5Qu2vVxSnDxxhax0buJ9dtRxRN5KLfgPHq6pwRiAAkeMYP
X-Gm-Gg: AY/fxX4iuyxZ6dF8lc35fiSTviGtlIIb50lLoUEDux7QJ280zCs49SyuSGRq2K+FQuN
 2kKHCxLbFXrL+nGM3Z2tVpyA+rNssXRpOyjb7nluksa1h6RAx9/ro2bfPk8fOtp/qjYaxxs8yBq
 e+rdrmgcXECr88tADE7plh4beTRYN1zot2848RMUd3MYz0IUSmN27ALBIEqazV1p7pQCeSEcT7W
 7IOKxCbt56Rk+a2+K0NZRfZ4SuEOl8YTot7685q08pYSrnn7TbVR0dzs80iJ7D7HjtthtTeeG6M
 hZqhRy0g/VGVtA/lTXDJX9kQQx7UgbMC1o4S2TEaT2Kyx+tjISjcW693fBSB02Me7+shtVj6DKf
 YiANJh72YbYLFQBYcTnlM3cBB+eOQw/ar2w==
X-Received: by 2002:a05:600c:8287:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-47d1959d0cfmr108274555e9.37.1766441674772; 
 Mon, 22 Dec 2025 14:14:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFD+OQDH3KKBSFnlyQHD4e2cCPQAfjwfmX0ME8GV2fS6KBUqwJep6/RWLJF+rx5g8Ksi1FIvw==
X-Received: by 2002:a05:600c:8287:b0:479:3a89:121e with SMTP id
 5b1f17b1804b1-47d1959d0cfmr108274435e9.37.1766441674337; 
 Mon, 22 Dec 2025 14:14:34 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3ac5409sm101122905e9.15.2025.12.22.14.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 14:14:33 -0800 (PST)
Date: Mon, 22 Dec 2025 17:14:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joelle van Dyne <j@getutm.app>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>
Subject: Re: [PATCH] virrtio-gpu-virgl: correct parent for blob memory region
Message-ID: <20251222171331-mutt-send-email-mst@kernel.org>
References: <20251222151259.3965-1-j@getutm.app>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251222151259.3965-1-j@getutm.app>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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


> Subject: Re: [PATCH] virrtio-gpu-virgl: correct parent for blob memory region


How many R's are there in virtio-gpu-virgl ...


