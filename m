Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2BCDC43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 19:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whueX-0003O3-1u; Thu, 09 Jul 2026 15:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whueV-0003N4-4o
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:43:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1whueS-000529-Lh
 for qemu-devel@nongnu.org; Thu, 09 Jul 2026 15:43:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783626194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ze4t8RQDgJtZ3NEcTxM9e7LB+aShuRWciH0bBxyppdI=;
 b=gAEkI22XhEasfrB00hd4v9TdNRcP4+Pdg0b9qNouGu4jP3Uoqi4WTMjh3bDjqhlvUwLoqs
 +xR60C4BbGpZMUE+m1MSyGV57NcfKqI5bejMIqKWxnrzf+ocsdwHwl4xJi2DUQyql/z88E
 tSKGxMfZI2u3lnKunpw/NL0ULgKHVek=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-hcZ-I9lCMXqn4VLf2RdMTA-1; Thu, 09 Jul 2026 15:43:13 -0400
X-MC-Unique: hcZ-I9lCMXqn4VLf2RdMTA-1
X-Mimecast-MFC-AGG-ID: hcZ-I9lCMXqn4VLf2RdMTA_1783626192
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso3543296d6.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2026 12:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783626192; x=1784230992; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ze4t8RQDgJtZ3NEcTxM9e7LB+aShuRWciH0bBxyppdI=;
 b=JOgiRHRrz61rJ10h7khiMHJZVd8LUDDxARrGyz5ieBP0QrhZc0R1gzuxw7DGP2Cw4a
 weBDtYvpg4FP8L7Qz6sH0xtmhdAGZCMK4DcIyK3mm3G8+jJKj9gzyQSb+RWAOm9+mrfn
 ejFnfE+xxHFM3qkApN1LoiX4KUHL+3XXoZBAVyCdw71SjwACArAJBSAE/5Wm4NURvXzZ
 N3rQDePM8647UdWdsidfGsufY4dAAtsRRm/N/OQxZdtgNjSqxF9BKhUwhjs6W87GdzTZ
 pe1YxwBa3eFh/xnuLLHikLs3FelO0gLrMhAysdMsAz1SzmDrbJJYqf2dG3zqOPTXufYh
 7U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783626192; x=1784230992;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ze4t8RQDgJtZ3NEcTxM9e7LB+aShuRWciH0bBxyppdI=;
 b=ZqihxBL8wXjeE8uM27pSrTlOaGs7+SeHy9XiN1BjqNaysxAw4mQ3G4eYeLsZZtPqZd
 l2qs7YaQvhGL0rr6M7djdh1xKbQI6Ma5wlF8mNkoiItuUg6w40e1yU4G34ZUNL8Jx0JS
 1uelqvWhlwSJ/uzEaWKCVM6zYFvICm87aSoy9TtNX4RA8lELGmMhuclWtrOI+6fp1dSZ
 MpE8r+x6f6yLrbULP0MzhU9LzCO7UIn/bY+HDZkep73eKB41c6a22QK3IbpET7wic0eU
 2VpZCZbggR/WqHMGLng1Kp1fwJFJ2vvJ1YdmzZxcHREUskemEVkGeXCS58txm5Ymru5D
 cqzw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvnRG6Cfq90KfCUePcmnsdHJuuSESExSQiqvP48mipL0u9ffs0TFAGHLVII9AhNLj4F0fXXOTqshSv@nongnu.org
X-Gm-Message-State: AOJu0Yz+iNBsWHBJ+2T8NpHhBwoUe6azlT4nwJT3pjrhV/6rJGWB2Qdl
 iiXOqeJ8WgtlyrDag4SK9GxzqZ5jd5uKSuTD31u32Jc7n08cVX2Jbjkmxhb59rimhE88SNNaYz1
 jyUbLKPRUuzSw3evx+fu8Vl21mFjvxBzQuOMMf/sg66FE+o8KDtZ1bWB8
X-Gm-Gg: AfdE7ck3Idg03g/zj0Ztt3WfjLRih+DS9pdVoOKNtg9BNLz3ro8z6aHtIKtpCOwoAa3
 rmwHY2/uakXQr2k3KFEMjQxfKZIY1+JvZlV770f0M5Z71yt/stO6QIbxxvbUAci1RfgejeXroYG
 1C3pKOM1Mv4/BeINy+WArR2BfYX5qKSi7ooX8HIKMFKzMCXQsX5lsofw0SyXQeASKwPuV3Aw3Ss
 Xto+G9DEpeY6UlSZWPKOykLE37u8BJ1WfoeMsxPQd5gPN+qdfXjgBv4+E7E/mML58gvQrKX5JSd
 /ocA9RXkLn++Cl2yYi8cOCVtZrvYdmgiDDcBuPNOaz8KJGBaxrs1QfMtknNfxV3Woy/g9232kwI
 ys9+ps9mg2bBYPDqHZzSHpP9vZNcyGJyjysg/GCDwTHtfonlnDBbpcHxuOjgw2RRkbg8eyw==
X-Received: by 2002:a05:6214:3187:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-8fec5b4a6d1mr99424716d6.27.1783626192359; 
 Thu, 09 Jul 2026 12:43:12 -0700 (PDT)
X-Received: by 2002:a05:6214:3187:b0:8be:1620:a95a with SMTP id
 6a1803df08f44-8fec5b4a6d1mr99424296d6.27.1783626191836; 
 Thu, 09 Jul 2026 12:43:11 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd56c06e1sm24647236d6.14.2026.07.09.12.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 12:43:11 -0700 (PDT)
Date: Thu, 9 Jul 2026 15:43:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>,
	Hanna Czenczek <hreitz@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-block@nongnu.org,
 qemu-stable@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 1/1] coroutine: fix lost wakeup in qemu_co_sleep_wake()
Message-ID: <ak_5zULusWIPrOBH@x1.local>
References: <20260610115850.2410566-1-den@openvz.org>
 <20260610115850.2410566-2-den@openvz.org>
 <b87db62f-6c9c-4da5-8382-500adc29b828@oss.qualcomm.com>
 <9cbdce55-83a7-4b43-b3b6-8123d85ab9c8@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9cbdce55-83a7-4b43-b3b6-8123d85ab9c8@virtuozzo.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jul 09, 2026 at 09:00:52PM +0200, Denis V. Lunev wrote:
> On 7/9/26 20:55, Philippe Mathieu-Daudé wrote:
> > Hi Denis,
> >
> > I tried to review, but not my area and way out of my confort zone...
> > Cc'ing Akihiko & Peter who might have more familiarity :)

I'm always scared to work on coroutines.. :)

> 
> I thought that v3 should go fast, this is v3. Not too much
> changes + unit test. I was wrong :(

This does look like to fix a real issue. I'm also surprised it got
overlooked until now.  Said that, I still think some block people should
look at this..

Kevin and Stefan are both on PTO, getting back either in 1 or 2 weeks.
Let's see if Hanna will start to notice?  If there's still no update in 2
weeks, I can help to reach out to them.

PS: I copied Paolo too; normally he's flooded, but sometimes he'll reply.

Thanks,

-- 
Peter Xu


