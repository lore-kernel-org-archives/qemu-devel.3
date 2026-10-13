Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E60CC6B03
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGXjH-00083q-8M; Tue, 13 Oct 2026 04:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xGXjD-00081J-8Q
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xGXjB-0004lW-AJ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791879556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iPH368QUS+D/RrqTfvUtCwjFx/hFbQOAuvZ5mrl6Wz0=;
 b=WjeVbU4b6Ti8g0CxuuYEKhlOgV+8UwD4wZWInsu6jR+Y1r2l8QLqbtRUZhJ48YnnMUnlnW
 LHuU3P/ZDgOz8aujPWncb2GxPzxZPGH4Ea61KJV7kZNft0v+IPhcALSq7dMICjtqnwAb6l
 YpNaC5e7BQ50zSAvCpXgq2R9ldeKHrQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-XvZayT3mMUmulbbVckJ0zg-1; Tue, 13 Oct 2026 08:19:09 +0000
X-MC-Unique: XvZayT3mMUmulbbVckJ0zg-1
X-Mimecast-MFC-AGG-ID: XvZayT3mMUmulbbVckJ0zg_1791879548
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1813fea7dso41858695e9.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791879548; x=1792484348; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iPH368QUS+D/RrqTfvUtCwjFx/hFbQOAuvZ5mrl6Wz0=;
 b=MS24OvtPdPozmGFJTtyAy3bV/E8LNUsj8/qKcynUZFV7y4Y3trsQv8apMQB45fxRjk
 D39xN1fZQydYo0li/8cyAGXC/nXkt2FQo4pmDcDARUxGlV8Ck6syi5thE6jkVgC+GWUc
 Rmz5Co4IBU2lfxt6qtTDxhThBQJ3zqCNL8dRGG7aKJ33zeuZs1O+hkwxQ3VnS15YDL9b
 2ofmr06q2XVUyGzA9/4+Ccm5fDKGV0ggYw3JyWiv0jyCD0lCuM+M6QOH931WisMl/oFR
 Z5hCVl3pO+E6coAO4qQPTvnUn5HiKZt7uKeTfiYhj3k86FV4F+faqECEdT0WwWC/nxTI
 nyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791879548; x=1792484348;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=iPH368QUS+D/RrqTfvUtCwjFx/hFbQOAuvZ5mrl6Wz0=;
 b=JtPyHim396z4Epv9aYxhgJbIcPcMwS8yUnyBuj9Sp8dBavbDYBiCk5RZ/IdgORF8ss
 sdNC8bQp+snANaFuSFWXeyOebGiaaGk43op0kAiQYfHd1huX9LCsMHAYkdg49blNIqg9
 +AYJGdMbplj3zEqfUabdsHVhvszMaIOBRTgVNBVJKD5APWgVNUMSxrZANJthUTW2UQL4
 ei0DzMLtKFkImF16taBnZRaMP5jOcD0ASY1pWxkqos+R+v6SEXfDv3i8Xmh4Dh5+b+Yf
 WWhG+rQh0BoBI36e0OZRZcZbEdpDR3fzxhItaihnDZxA/0mAYDHHSWitBvl0ydvfCOGf
 1RHA==
X-Gm-Message-State: AFq9FYL1G7LcVjz/5qj1K6HYjPOxSXqlK1qk5Trv1qEsFHFwyYmoo1dZ
 ks8jc7fsd5qdAuOrfWFQFFgqr90aQ9hGjc/iIlGkdnXJdV3auGYb4OER75XChFxAhY/5HOo3ETU
 B5nlcKiPqZF/0J1L/Hw7vHADaZKqvB3y4mLrGLutRNr0Jq75oiHytS/tR
X-Gm-Gg: AYBFou2GXQpuimuAUwqMdqbfR5S/lSTkDc1RGJ9VKKSgfk1hhh5ptf2CQoRJPHV9kcf
 qFOIodBl3DN1MqM1BvQoYUN5m+gfzz5xdcX7Wf2dh7HahgAr1fr3AiCO+b2REgTVj9ETPE1eZqj
 om3Bi/6zMELbVvnpv5DhzzToZBwrPjVpQnKl/jJGVSNEUn3B+lijbxPTa6dCw9wWMkaHDWDn0C5
 0pZbmD7QuPbrvX9KpjRtebD+hmXlzd8LdTnmILwFtD/lP+vTVqf5l1apjRe9Z28l2w/YG/GZF4e
 2i4Nkj0A8HRnxnHo+ENhcX1lm6bqgjgB162NB8kkL+nuS4Z/v8gyfsrMUN7m7BcT7u75vb8EPAT
 nCqsnLNeUrHHgwel9VnuchvtWjTGjSz/aBjI=
X-Received: by 2002:a05:600c:5397:b0:4a1:7ba9:da2c with SMTP id
 5b1f17b1804b1-4a18e4a7cacmr228129875e9.25.1791879547325; 
 Tue, 13 Oct 2026 01:19:07 -0700 (PDT)
X-Received: by 2002:a05:600c:5397:b0:4a1:7ba9:da2c with SMTP id
 5b1f17b1804b1-4a18e4a7cacmr228126435e9.25.1791879544631; 
 Tue, 13 Oct 2026 01:19:04 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18beabbd0sm399515415e9.12.2026.10.13.01.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:19:03 -0700 (PDT)
Date: Tue, 13 Oct 2026 10:19:01 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Tommaso Califano <tcalifano@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, 
 Junjie Cao <junjie.cao@intel.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, 
 Abizer Lokhandwala <abizerlokhandwalastd10@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/usb/dev-mtp: Fix assert crash on undersized BULK IN
Message-ID: <as3otb2jmb6SVTUw@leonardi-redhat>
References: <20261012140839.93559-1-tcalifano@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261012140839.93559-1-tcalifano@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 12, 2026 at 04:08:38PM +0200, Tommaso Califano wrote:
>The EP_DATA_IN result path serializes the queued response as a 12
>byte MTP container header followed by one 4 byte word per result
>argument (12 + 4 * argc bytes).  The entry check at the top of the
>function only verifies that the guest-provided transfer buffer holds
>at least the 12 byte header.
>
>If the queued result carries arguments, e.g. RES_SESSION_ALREADY_OPEN
>which returns the existing session ID, the second usb_packet_copy()
>writes past the end of the guest-declared buffer and trips the
>p->actual_length + bytes <= iov->size assertion, aborting QEMU.  A
>guest can control the transfer size freely, e.g. TBYTES in the qTD
>of an EHCI BULK IN.
>
>A device must not send more data than the initiator signaled it would
>accept. Stall the transfer instead, and keep the result queued so that
>a subsequent BULK IN with a sufficient buffer size delivers the full
>response.
>
>Fixes: 840a178c94db ("usb: mtp filesharing")
>Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3386
>Signed-off-by: Tommaso Califano <tcalifano@redhat.com>
>---

code LGTM!

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks,
Luigi


