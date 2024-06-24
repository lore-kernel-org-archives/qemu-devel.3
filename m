Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB0EEC2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 10:25:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLgsO-0008UT-MK; Mon, 24 Jun 2024 06:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgsM-0008Ty-Nl
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:24:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sLgsL-0000FP-G8
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 06:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719224681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iM11OO4SiRnwNxmrfUxUKOThrETXsIrwlvl+1l2huyA=;
 b=CMJX/JBEg0JdQzjNMCM81DUFarB8CS/5vl683OxkLUIooqGgrsziy8qeCLItkIvQv5yBEJ
 aZSP9VYu6FI9zKAdCZuc5bM7pezOD5h6I0+icZZgb8TwfYoRhT3F37yPeYiRsMxVCQKKnh
 AVDQh44Im5K0G6yMk9Zrt7pIMd4kVVU=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-xexkuNpJOcyH-wapqJ7L0A-1; Mon, 24 Jun 2024 06:24:39 -0400
X-MC-Unique: xexkuNpJOcyH-wapqJ7L0A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-57d0f3455ceso631717a12.3
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 03:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719224678; x=1719829478;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iM11OO4SiRnwNxmrfUxUKOThrETXsIrwlvl+1l2huyA=;
 b=PAZLTb7CjXwfx6FQj4DfxCJwt6lbmtoVMe8Jm3iq4nSmXRSkJ6OYEBtYIBZK1lRvSC
 ILtZBLYenCmmrJcsFYLX+vpT+zh1BJ8k8lJGq7BN29YMw/jeOh8tqJM021wYFPkY/D0E
 lAMWSrmfmIWWLU0Ja9oVV6/AzHKtD5H1s6lxxCSs+dN6Ea+5rrKVQBR07Ts+m9hqaaSS
 /0yGXGetMKCplfiTEzVlpJXyUjYXCNnoo5POZx4Ud/TnZB1Q8/70nl6ptStPbbg97vi/
 dwb1sZuGBjnbFkTKFKp6KLNIS2i3iVvCE+Kn/1wTzcjA/V/Cl3QvQ/wnkDwljXi7CzZp
 d5Fg==
X-Gm-Message-State: AOJu0Yxx3Bak88ME0ItNZ8H5ctCtQt61qiAwxDa5ByaU5cJcwiGrWgDE
 RnXEQRockfeSmXcatBBfPK/8N9gcO1Xe5+8B/AtNJRKDpkshVhi6KSYXiGFgv4gFPTFMGpT+iYj
 gCwP4V5MSq1cdc8dEStyQWW+LgPbQZEwBEZM2NWxSM+VWoxB9WORb
X-Received: by 2002:a50:d481:0:b0:57d:10c7:96b0 with SMTP id
 4fb4d7f45d1cf-57d4bddfb93mr3016075a12.38.1719224678008; 
 Mon, 24 Jun 2024 03:24:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCaqqqRMX2gX856/225iJ5zFYnbEb5gW29yVh0Gva1kZOkpkA0ui8ZIv7c5n1/7LrpHK/Omg==
X-Received: by 2002:a50:d481:0:b0:57d:10c7:96b0 with SMTP id
 4fb4d7f45d1cf-57d4bddfb93mr3016048a12.38.1719224677210; 
 Mon, 24 Jun 2024 03:24:37 -0700 (PDT)
Received: from redhat.com ([2.52.146.100]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57d303da3edsm4555955a12.2.2024.06.24.03.24.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 03:24:36 -0700 (PDT)
Date: Mon, 24 Jun 2024 06:24:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yang Dongshan <east.moutain.yang@gmail.com>
Cc: qemu-devel@nongnu.org, jasowang@redhat.com, qemu-stable@nongnu.org
Subject: Re: [PATCH] Update event idx if guest has made extra buffers during
 double check
Message-ID: <20240624062345-mutt-send-email-mst@kernel.org>
References: <20240613022147.5886-1-east.moutain.yang@gmail.com>
 <20240617065455-mutt-send-email-mst@kernel.org>
 <CALrP2iV14404dq+5xO8Ziq4fEuacvkU=SjJLT=FJGLAq1Xanhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALrP2iV14404dq+5xO8Ziq4fEuacvkU=SjJLT=FJGLAq1Xanhg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
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

On Mon, Jun 17, 2024 at 09:51:33PM +0800, Yang Dongshan wrote:
> Similar to the first check, if the buffer size still can't satisfy the request,
> notify the
> guest with the updated shadow_avail_idx, it's better than the old one.

So it's an optimization then? Same as any optimization, it should
come with measurements showing the performance benefit.

-- 
MST


