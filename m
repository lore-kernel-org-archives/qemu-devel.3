Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E087AE7716E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 19:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJHrU-0008Eq-L9; Thu, 05 Dec 2024 14:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJHrN-0008BH-5E
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:50:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJHrK-0003x1-OF
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 14:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733428197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EHluXiipnROaJep4nLChh6teFVF6wm4C6E/dhewa/fo=;
 b=XMBd+30jbcWssbLw+Hvr1FUueJ0T0nB7sq1PUAkQ/aBl3Q1fshJaZZsicNoel0+9wwl12A
 oh6LdEi5IIYh7ACGJ8ulpZ4AB5+/bPo4ykdZAZ75iYasy7rUN6i6I+dNNJWCytcgvPB2fO
 PMzfBQ7JkujA0+F3rYSG/rOFf4QUdR4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-E3cR0vQTOICuPhXuQRZwvQ-1; Thu, 05 Dec 2024 14:49:56 -0500
X-MC-Unique: E3cR0vQTOICuPhXuQRZwvQ-1
X-Mimecast-MFC-AGG-ID: E3cR0vQTOICuPhXuQRZwvQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-466911d43f4so25531731cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 11:49:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733428195; x=1734032995;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHluXiipnROaJep4nLChh6teFVF6wm4C6E/dhewa/fo=;
 b=vq3SbaCBTq6k4Dt3tgp+nXTFqfUEM2yuKiPhcnl6Jk6OTEFUPMtlBJTvglo6t/JTKX
 r5non7MDrhi68jXuI1zcl9CGNQGxgITb5h1d3wlElxgKkw2Jra24YrnR3HEEQAZqXUSO
 4r3wTA9yi4dnDV3Ae/Nzio0yHK6qOXwCzI4X7xORNk7pOrH9ThRskV0RUGH9kyT4VASa
 T+NvojIUWZrlCOOnrPexo6QOM4F0vLpFgamONM/YXbsVPUqH2x28FyapN55Ur3W1gDZn
 e5PhV4QefQIoFgSnjKypgta+KhJw1BAN5v/5sAKybf+iipKQtTYg4vYJMu2nStNjKKhT
 lgUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlDyWN0ctkqkLd5C6illGQVjjsBf3ByOJpD5izry94pjJMmvZ6zae/34wjlsmPYDRPhZOMkqN6hxsg@nongnu.org
X-Gm-Message-State: AOJu0Yw5xOS/RZhPcTU9rXvyZQVC4OjjehKcdr2qZqY7DcboDS4MWIIU
 0GnYErQVp/BDcyYb+xLOFZLT/LSE8e7mSyeF088uLPk2r//7Dsi2WAeDyrcJRC1G+yc0QVVhqJ5
 NrwR9R7uCLmqfMik6E9t+C0t7S48Kj+VD3g0rIya2VhhtpWm6EmNj
X-Gm-Gg: ASbGncte57+OLWBCWj/InTv8KwUMURV83psp96In38h/cu9z+CCoKi0/5moX3TOyNMs
 5qXYlJVhkgpnc5MTFMcE1cWOH9HjGA0vw6QRcvz2NPo+5G0/gpg/d5/na0jY3dxbT83NZfant1s
 Cv0ZvFG5mROjAfdBtLtlCjfhM5MXp0lZf32iply8OV387KyUVSPd+Yywh2UD7/W8LyxjO7zlOv4
 21dvyoaseV6lwnmEfs67F7j9CYXNDMuL0jrKdZTPw3yJlZE1JKhjlyev81dwulbI/2mz8N9ecvg
 9MoernnFLKo=
X-Received: by 2002:a05:622a:409:b0:462:c4b7:6b9 with SMTP id
 d75a77b69052e-46734d24433mr7660131cf.33.1733428195679; 
 Thu, 05 Dec 2024 11:49:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRAGdLkk2xw1p8ksmUj7Bzh65Tg2foXeyp2cPouZjrySdibwaD3SjSnTuSapt7u8sibX3bNA==
X-Received: by 2002:a05:622a:409:b0:462:c4b7:6b9 with SMTP id
 d75a77b69052e-46734d24433mr7659851cf.33.1733428195410; 
 Thu, 05 Dec 2024 11:49:55 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4672978dd14sm11203051cf.54.2024.12.05.11.49.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 11:49:54 -0800 (PST)
Date: Thu, 5 Dec 2024 14:49:52 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 23/24] migration/qemu-file: Define g_autoptr() cleanup
 function for QEMUFile
Message-ID: <Z1ID4EZSMZ3szQGZ@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <952bafd5a7312f04bc7f05068a1fdd4c64be433f.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <952bafd5a7312f04bc7f05068a1fdd4c64be433f.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Sun, Nov 17, 2024 at 08:20:18PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Automatic memory management helps avoid memory safety issues.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


