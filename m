Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298A9D4335E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 13:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t92oV-00014x-Bl; Thu, 07 Nov 2024 08:44:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t92oE-0000w5-N9
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:44:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1t92oD-0006Wx-Dp
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 08:44:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730987064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91Mv1TKI/oOdkPWqganNptuMP3HOdJhdTaI2uqLDwi4=;
 b=VjHZBDYPKR4R6N0c3xA2mdCd98sVBQkF4C/7OYgm/O0bhpvJbWnMHAEADdhBt2DE9sdocg
 wpcMJp0YMt7zWlmKydQKulH3lIXmhNYrFL3QNM7WxD2/aEMmCqR/F8MRQFsPBYY7QcyFec
 4ZqehaDlvAF5E07TzYfBUFsvp5XzpW8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-Z2cfpldxPD2KUMxjozdmpA-1; Thu, 07 Nov 2024 08:44:22 -0500
X-MC-Unique: Z2cfpldxPD2KUMxjozdmpA-1
X-Mimecast-MFC-AGG-ID: Z2cfpldxPD2KUMxjozdmpA
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-a9a1be34c68so78401966b.1
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 05:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730987061; x=1731591861;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=91Mv1TKI/oOdkPWqganNptuMP3HOdJhdTaI2uqLDwi4=;
 b=erJ97bFAu6XIJHwVEVUXMO/d3N/+kc2sWP0uXBFuy7N9my/4FqOK59LJn2Cjw6SqIp
 REKMAAiCR+otJ26Vpb+qXt5ZUpu/WR3+483H8vpvCwgqMOvXZ/v5iC7V5wa/33dgEXUM
 NyU/sA1NCnX6jBw7Z+/lYLLX6Sg8NnrYyg+VDbwfplD9csjdSwHPhX1t26CiN4WLk6JE
 +1LZjfZAw83pWdec6KqcQqzOYsWx1/99nLbwH4xFeE3sQYcuRks5AgUKUtOBTUX4xznL
 bTZlkg1j3FWZ9FtIaA8lQFDwyXp03N1A3tVAJXT16jqrPdohAb9pO/RSHVo1tsD7q8sP
 0Z2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVuv+aSBrxn9RLcOrNWmMtuJMsiuPtNKE5P8DPX4QqhD+YUa9DYHSrgWj5ZHjVjaAHUlutw7uuZrBJy@nongnu.org
X-Gm-Message-State: AOJu0YxJUMTv/DZ9QugAAUWzGK6dOJOzmMv9tY4Nzhkte6fjqrp//6h6
 qubBqixIeSogOCZ8y5dEjDp+2ootuLqvs6bPyh9Ii4XWTdFh6NuDahgktKT6/V9z5qj+1uovhDv
 8+/NBhteuiKyAYABDrIOEq0H9oZH8afm7iRmjzm4KTpRVQ0ESSYtv
X-Received: by 2002:a05:6512:220c:b0:539:f5b3:f87c with SMTP id
 2adb3069b0e04-53d8596f4a9mr4852e87.46.1730986636204; 
 Thu, 07 Nov 2024 05:37:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHj/8CDbtU3MhsV0pFE6UC+1dS5e3L84Sig/BPrAuhGxvfT9eQzZbP4QWyS+pPBn2rPkVgpqA==
X-Received: by 2002:a05:6512:220c:b0:539:f5b3:f87c with SMTP id
 2adb3069b0e04-53d8596f4a9mr4834e87.46.1730986635799; 
 Thu, 07 Nov 2024 05:37:15 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a2ccsm64283225e9.31.2024.11.07.05.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 05:37:15 -0800 (PST)
Date: Thu, 7 Nov 2024 08:37:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Dorinda Bassey <dbassey@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, mhrica@redhat.com
Subject: Re: [PATCH v2] virtio-gpu: Add definition for resource_uuid feature
Message-ID: <20241107083549-mutt-send-email-mst@kernel.org>
References: <20241007070013.3350752-1-dbassey@redhat.com>
 <CAJ+F1C+xoof_ZWkyi1Qrx4=9NsAq_v8tLrV0PHpwWapprkA2ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+xoof_ZWkyi1Qrx4=9NsAq_v8tLrV0PHpwWapprkA2ng@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Nov 07, 2024 at 05:09:28PM +0400, Marc-André Lureau wrote:
> Hi Michael, Alex,
> 
> Any of you could take this in the next virtio-related PR?
> 
> thanks

Sorry, we are past soft freeze. So not unless this is a bugfix.


