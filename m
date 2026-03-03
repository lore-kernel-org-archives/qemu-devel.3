Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B777AEDEBE6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 18:58:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxUwJ-0001Hz-6Y; Tue, 03 Mar 2026 13:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUwI-0001Hm-Eo
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:57:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxUwH-00038c-1P
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 13:57:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772564268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UQOsChU7m9iCKe33t/K1RZDUR4id0Q+WNCyialfJOE4=;
 b=I6SP/ePdE9KG/udkZZXGpvBWVE5gYrFGwh/2eNrm+/ba2uKSKyaarmaD3ZmX83aS02vNv6
 9RN/HFoAt1PDowKRNrH5MaW4G2hljq5qoflaNJwBQ/sqqaQChmx9rgCh5Ip9rLvNCBmYE3
 b0XdwUlichN23L5pmk76Sg2J8/SkcK4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-VlyTHnZjPc6lqxmNgfQr4g-1; Tue, 03 Mar 2026 13:57:47 -0500
X-MC-Unique: VlyTHnZjPc6lqxmNgfQr4g-1
X-Mimecast-MFC-AGG-ID: VlyTHnZjPc6lqxmNgfQr4g_1772564267
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-89a08e6cd15so76772216d6.1
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 10:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772564266; x=1773169066; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UQOsChU7m9iCKe33t/K1RZDUR4id0Q+WNCyialfJOE4=;
 b=jg+IlmoXLX+Ewf7e/VVjiE3JOJkGt+hgs6PaiEkMmgRLdw0/E3oYoLL4aJCNfYuVjr
 7QKI4LS1gyWlDTXX14ISbsgHWXSgXqEXgAjMT6VjLWCiTlbZ/F2At6o+MeZj7ct3cb0t
 FVJRbyGqK3t0V+4PWrPMgqse4kmUk87RBLVA2ch2RnRtKy9WuJxyPoEmSPsgD2vxmFDR
 /oU9bLc4MoUNlA148QZU/CUzzdzIR4dSIjPcMvaj3G8x6vGLwyJeOw29+88YP4JZ/Ivg
 Anr11refqIiE+HWHHijwotoxOGMZn3WyxVYLHbdRUxBPsKoTPIW2jGNjjDtrRQjWj1Tr
 W4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772564266; x=1773169066;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UQOsChU7m9iCKe33t/K1RZDUR4id0Q+WNCyialfJOE4=;
 b=fMCvp+BijN64Jxg5eo9ISP0GdtdP96kLpbO0t+rAp/YvaCbx1BR4M2kovEu3D8ytan
 g9jkiL7vJEj/KXh8Ku3GzUj2n8OLsl9+dTGCjDR65Ww+PzVxgARX8Z0EGf2/+KVXRaxK
 UO5ulgRPXpLi9ApUAxFyzE9lIxbWxd8JvPbVc4LbhY61tKw51lLlaJcqQsuCdmZLrYjm
 xN+PqSfdilBt/TKjkhmqeNEIsL45Sx90x/W9nTBLmPvuTjZiSYw1niknDdKpQEK9GL1w
 7fN3gGlBaXGZ1L8CXI9uVEEcnJq78HKWmC6m0uKqI3nY3SKKoA2mUwdgVXJVxsgcKpBL
 EN/A==
X-Gm-Message-State: AOJu0YzBVyvmxivNUFC2jnjgpP4GcQUPmDlM0xYPPvRu018QAVV5oSXD
 X3EL7lGmY6DEKIny5g4JvhFcBZjlLMvS6QTdcTbB7v1E6qzvIUl87H7OXjeVKdzjbAZy4rzXWUJ
 WDnlXpnDKSP8Eo56Qte4aJfNpFzykpOChcxys95xtNq3rRbYoodFduLjNW4oB/nB4
X-Gm-Gg: ATEYQzzlttvE5/p/Cs3b9dbLZ1GhQztbbvUlHdu+laIinGoqdtiiixQw/6eOikNF9H8
 4awSymCkgS03yHJvYqUtAWrbd8OaqD7iGVnKMhjo+hJnRYUpPWPUX/LbCa40piAEFY3taGT959o
 dXX6bnJiZBDtSUksHBoi0YtGE6bcgVBG8jKCEak29LaDmzW2i6jCg05XYRZ2sk+1tm8+nkkMTzC
 x+aAdHtQmK1+0AHHQN7Cy1lFgkqBujBFLQc7MsTpPtP7WEIVG1u3N6FOMq40Yb5h9t3a5lhtolM
 b8vYEHKN0LgEdGA5MPYcCL1URyW5H6czDE+l7ayeWXudt4rt382Y+YRLD8vaAsXdkBvUBopEStM
 YRG4TZVdYygCL2A==
X-Received: by 2002:a05:6214:f67:b0:899:f5d3:321c with SMTP id
 6a1803df08f44-899f5d33666mr120445376d6.10.1772564266266; 
 Tue, 03 Mar 2026 10:57:46 -0800 (PST)
X-Received: by 2002:a05:6214:f67:b0:899:f5d3:321c with SMTP id
 6a1803df08f44-899f5d33666mr120444946d6.10.1772564265700; 
 Tue, 03 Mar 2026 10:57:45 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a056b7b7csm43713926d6.20.2026.03.03.10.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 10:57:45 -0800 (PST)
Date: Tue, 3 Mar 2026 13:57:34 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 01/15] system/rba: use DIV_ROUND_UP
Message-ID: <aacvHhRpKsIuTif2@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-2-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:46PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Mostly for readability.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


