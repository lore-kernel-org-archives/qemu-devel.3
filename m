Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C57BC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 16:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlqTu-0006in-7J; Mon, 20 Jul 2026 12:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqTP-0006UF-Oy
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wlqTO-0006Do-1k
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 12:04:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784563445;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISVjeyYBBMnRNOw3bfZExtkj50sCHw4KaY/nxKUdGZg=;
 b=Gz8e+BAK3t9scOJFQmEv0MQgw1JApR23F0tt5bAyMYFnXwZVPjUpSLfrZT7SQ62d6mz7uo
 nAQTzje2yamP8n7/Djp4NRiYIfBdMA3ThDBnYFBYPSRAnwefAadVum3n50T7lx0hgw7hg+
 joxEmp7JncD6e2KTAkru04QsqEwlFas=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-thwJIyRnPpGqMG2xoWW4-Q-1; Mon, 20 Jul 2026 12:04:04 -0400
X-MC-Unique: thwJIyRnPpGqMG2xoWW4-Q-1
X-Mimecast-MFC-AGG-ID: thwJIyRnPpGqMG2xoWW4-Q_1784563443
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92ec91dc265so668832585a.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784563443; x=1785168243; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ISVjeyYBBMnRNOw3bfZExtkj50sCHw4KaY/nxKUdGZg=;
 b=NjiRIAdcjOkW4Jw2RRLSxAKBdx3ZsfiA22z5aN90/lwzLJj7O/Kg8HFAbKdn+oalr9
 ecXxp2JjCQxw3dDGARCTmeXR3TtVHdn3QWPo3Nv1lJjiV2vOW9csiX5Bgn4Q77outcYf
 quWDQg6S5JwX1fqLt5OLRH+zgSqkDIvptMbVg/DKsuHC3xu2xwqAc89Xipmv89tHPte5
 Rwp6Atlg1eVdr1V6Nir+lgWdpPZulCnNO7i/gUFwZFRsvLXX2dqxg8PHknSMpl2gXX3b
 Q0p0N4ETxUPE+i6mjn/V0EZl6eQw3dm8Y9AjRL9XV2DR3ExOTieTYiJCJcsq5YYpR+Zx
 /2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784563443; x=1785168243;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ISVjeyYBBMnRNOw3bfZExtkj50sCHw4KaY/nxKUdGZg=;
 b=nfNWz70Suq/wSx8+8GQTtExw2zR+TYlta0N7v8XjGG1e730r14ZmbaBqcnVYBFKIYi
 LZxFUMQ5U1rMvcB6JY9OBREuFtVA/ELVOMOm/LPJpEQ8JkmXPAMEYoxJeBzKTFRGJ/Qt
 zolU3UmkNMFEhWqL7MKCut3IkX8KRmPinkoJG5GK1QCbutQZdckW8QPKqBDBwubs8/kO
 VlFw5qLvrGLh8HNEqRZYuZNvxKcWXRnwm2gWfLNleZxMG8pl4rQWuXQIK+Lcag2sYf+q
 TkNJoZeLXOvehNqFdJ1iUmsLQHUEi+MBu6f7ybK+Ym7hzqdkWETDO3CHzUbic2979SHj
 Tf6Q==
X-Gm-Message-State: AOJu0YxGufif2ERB6nlBzhMZqlUiMzQpmxqEeSqxDYaOnve75Zz3GAXv
 LbQ2andobeE6a+csJQH9NUAwgwxyw3qXLNjbRndyA0PJDvLkAq+sXAfHgQ9BbAeU8RRwS6dZ61W
 75a0n5qX+Hacz/MXFRPEHXbUGFXBdScPxV4mPKFQT2ERh+xp7VKLboo4a
X-Gm-Gg: AfdE7cnCNVR3aSuNLc5yZKx3AYpJNDgD62nIQeKU3lnZB62ytwe3rQDfgsEfzZWwlbS
 F5JioPRpzQX+wgx5rZn5Lt+Y2LtjJTEE1kztqhrbLsHTgqQLxvX4OOxdAp9HQrlHIg92AvOcTZ8
 dsXRgVj56IChSe8UkjM2ToYfickoRW1vWHlom4D7AirYx7PMGqs8nqkJlEliGUXQmT31m2V/Onq
 A2prEz6Wm55YpioHTzibqh48FlKLmFjKlER8EeBJH6Ui5UZfn2mxCAOoXC8N6NwhduXrOAzAJ4H
 PxN61XsHkpNnZMF0mWTWqvN4t1qq3D8KExKikMX9Ek4pz1Cx9gfWQ7/Lr3+iq7Ld74WRfxepwjW
 Ha6oXKOlA7rOjtlevretH6f9baGB406r8jIGgS5x3eV1aV3oeDJuL3kErLPg=
X-Received: by 2002:a05:620a:17a2:b0:915:fad5:90a5 with SMTP id
 af79cd13be357-930b416d520mr1527008485a.54.1784563443309; 
 Mon, 20 Jul 2026 09:04:03 -0700 (PDT)
X-Received: by 2002:a05:620a:17a2:b0:915:fad5:90a5 with SMTP id
 af79cd13be357-930b416d520mr1527002985a.54.1784563442573; 
 Mon, 20 Jul 2026 09:04:02 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930b52dd4c2sm908692685a.6.2026.07.20.09.04.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 09:04:01 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:03:55 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, pbonzini@redhat.com,
 philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v3 05/11] migration: Make qemu_get_buffer_at() thread-safe
Message-ID: <al5G67QLURcjA1q-@x1.local>
References: <20260714141547.1268000-1-aadeshveer07@gmail.com>
 <20260714141547.1268000-6-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714141547.1268000-6-aadeshveer07@gmail.com>
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=peterx@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jul 14, 2026 at 07:45:41PM +0530, Aadeshveer Singh wrote:
> Remove the internal QEMUFile error state modification from
> qemu_get_buffer_at(). This function is called by two functions, both of
> which already check for unexpected return values and handle their own
> error reporting.
> 
> Removing this shared state modification makes qemu_get_buffer_at()
> strictly thread-safe for concurrent disk reads, serving as a
> preparatory change for the upcoming fast snapshot load feature.
> 
> Removed local error by passing errp to improve on error handling,
> consequently also change caller to use error_prevent and not error_setg.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


