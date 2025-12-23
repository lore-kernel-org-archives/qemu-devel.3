Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B98E6F093
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Ly-0007W8-4C; Tue, 23 Dec 2025 09:27:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Lt-0007O9-HL
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Lr-0002jP-BR
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:27:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RysFgWZ63j+OzSKgZM8x7jgxZu/q/KbdEYXZQuSGHlg=;
 b=TBDzCFBYIaaqLfwg6IsmfO3bfM34cmd9mSWejtVE0IpoeU9cUx21LxjOh00mkDK7cqlljO
 Zdrbj9VQ+y+oK8Iyo0XlYqjmripVBdRAbbqvg5NB/CMEAt7MBl0UOPaouS0sVOPx/drnLQ
 A1x+DqxZizCJn1JfcWGu3xkL2X0W2+s=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-XBxmPNg3NheLSLzlJtciCw-1; Tue, 23 Dec 2025 09:26:57 -0500
X-MC-Unique: XBxmPNg3NheLSLzlJtciCw-1
X-Mimecast-MFC-AGG-ID: XBxmPNg3NheLSLzlJtciCw_1766500017
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b234bae2a7so1192638785a.3
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500017; x=1767104817; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RysFgWZ63j+OzSKgZM8x7jgxZu/q/KbdEYXZQuSGHlg=;
 b=bMlE4WwfA0XnBnXPvJrbW0+WAmbLDrGhDikjAgQI97Gq2rBdaHmButWf1+N8JORfjl
 oALmkT7MeNfZnUXjMvkVk6DXYkdwQtWNkWUxD9jBAyXOlY9kwcv1oY5bon/uD6FPRm0/
 SrVGKx/DDv++oo/zs/osiEUFa0+/oaI1XMQelCCj40ttMH1PVPDE2gnpsQ8tJqGNZrgb
 mOkbH7/2NOWhjjh0cgbrINXD6ExKxc43KYkTXGh7/L9vZ1oNe7J4DPAYgcipHHJYVGih
 i+VxDX2l5MK+Y0/d4/AvNWDg9QJ/vh0peKrrjtH1wYlGrtFyKFo3+gfshT7j2Q7Bh0V3
 2BfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500017; x=1767104817;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RysFgWZ63j+OzSKgZM8x7jgxZu/q/KbdEYXZQuSGHlg=;
 b=Paj92La33Oo7cYmhI5/FFlvNKPUZ962EeY+yUuczr/YlDoLlyCs6w/DtNdkqOlrHYV
 bgU5kCR0jhQonEd9DaBfwziXkYbGYgFYbylMBeXmKO7iQ/PoBYkr1X507ah3n09LvOcZ
 z+xJdIf3u57Z2g0e3VfdyFLWoWiZVtQ0CMy74sqPb8VdbxldLq2z5ZPExrOCnA6DLE3w
 nhVzXAst9Rqv8UDTHFushnf9CKTlIAa66FNWAzZtcJE1SOq8smHVonME/dfb8XJSuAyW
 OKISlP7neSySH3Vw0jyjIPmCGaHunFDwxBqzMxzAy+iL1cPpIZeK5VruCjZwLZG8cO4c
 1khg==
X-Gm-Message-State: AOJu0YwsZr5IKxKD25BdxRd1YFwgRA7Lr8ss96j0kiIwAx4ss5sJ3cj2
 lLANhbdkdYRfl8v7nrmqjIAw/VIYdWQzyOyDbUTthrM0B8qLOihhtF3sMpQ5UyqdyrktvLuxNR3
 LgFIewNe8qlf15zPONZN9k1xdDZwvveM7D17ffVpFMaelHECLf0BGq1br
X-Gm-Gg: AY/fxX79Y8H4wcdutQVj6xOehJbdFfFWDoZ+pGdZjG6RqphesI9tHkgr9Tq6EMUTytM
 +36nrTQ2fxcga/fcyXKqabFdkmmqzn6YVAZcV2lgPSxwlmPiPk/yoTG2C5czX+hyhIAdngOsoqd
 Vp7hq1F+gbujrb+GbgAZ1AEt301PDLQCWlGO2NQBN2b2tapF+4UZXxFcOwGd0VB/dLopQAbR+H0
 gNvcZYxJTEuR0lkl9R8UoFEo4N1sjPpGf4YT7MRwnyB7rHNStSlfbt8+4baDCZF/AG+EoZ/Jd/M
 EIUdPEX7T7xg6n9zcUErZ8RsLQzRNlktF1FDau+pDn5XzfRMg9ycNYzaK5/UrSm+T8p/hJLymjX
 l8ls=
X-Received: by 2002:a05:620a:1720:b0:89f:5541:b5f5 with SMTP id
 af79cd13be357-8c08f65120bmr2352342685a.17.1766500017113; 
 Tue, 23 Dec 2025 06:26:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHFjC4lnHCNtRkgBS1087c8s7W14JdaChXh8BRuR9tFI/0tSHTx3bRHyyIdGR88lbeaDiWq1A==
X-Received: by 2002:a05:620a:1720:b0:89f:5541:b5f5 with SMTP id
 af79cd13be357-8c08f65120bmr2352338285a.17.1766500016638; 
 Tue, 23 Dec 2025 06:26:56 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0968913f5sm1083644885a.18.2025.12.23.06.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:26:56 -0800 (PST)
Date: Tue, 23 Dec 2025 09:26:55 -0500
From: Peter Xu <peterx@redhat.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v1] MAINTAINERS: remove David from "Memory API" section
Message-ID: <aUqmr2tucbBrnrEq@x1.local>
References: <20251222141438.409218-1-david@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251222141438.409218-1-david@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Mon, Dec 22, 2025 at 03:14:38PM +0100, David Hildenbrand (Red Hat) wrote:
> I don't have a lot of capacity to do any maintanance (or even review) of
> "Memory API" lately, so remove myself. Fortunately we still do have two
> other maintainers and one reviewer :)
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: "Philippe Mathieu-Daudé" <philmd@linaro.org>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Thanks for all the previous work, David.  Queued.

-- 
Peter Xu


