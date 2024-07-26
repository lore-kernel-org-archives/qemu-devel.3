Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382B5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2024 15:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sXMSD-0007k0-A1; Fri, 26 Jul 2024 11:01:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXMRm-0007gT-Fm
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sXMRk-0001SJ-Ao
 for qemu-devel@nongnu.org; Fri, 26 Jul 2024 11:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722006086;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/IJGVERML1f5i/eU6C9c73UmkODilxKPCfmlNJoMc/w=;
 b=Ikj5+DfANksNWhomKUn7/UYRziJxy7rO1cBNvHgP/VzFFebpTrSWB7c6+e85IUJIRFWVvy
 wpTcTZ+p1CF8ZX+arfoHYMIUgpBURGWEmrgbYqTr1uwDN5/wPhPlgFesWo+QNkRy3uPKYO
 J/p2GjtVu79/L7sJPqUJ1vioajxeVTw=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-EnfTsp8lOiC7N9q0IMCl8g-1; Fri, 26 Jul 2024 11:01:23 -0400
X-MC-Unique: EnfTsp8lOiC7N9q0IMCl8g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44fe05a4b61so1302221cf.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2024 08:01:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722006083; x=1722610883;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/IJGVERML1f5i/eU6C9c73UmkODilxKPCfmlNJoMc/w=;
 b=XhI/8YoMxS/+oLd3ekOTIcZU1OcbhXJYjwU/yJW80LP3hbCvaU8OXr7NyjaThZBjvO
 e5DDjHRMtULIepqNViAIJVNhXWQYMMRrllOh9RnoSEXMf9UrwO3FtVDmQylkwWxWcQ4u
 cC6d97/82ptBwItqKbrQCw4yIMEVw1j1Pxf7U0KxA7dkVDWPty/dnYSQ2wH4OtLacgRT
 mfyXffsEbVk0H5TrEm7CwmK/ppgomdNlYQ4v3wANqvIasqatSoRT+dMdQt2alFP/dNdZ
 tLVD+ugwnnpKMqJYhe0Y1aybnnaRkJfIPd0wVpf8Ld84TRHKFNdmU8zllCFXUSW6P+Ym
 kGKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9Xyo7qW1jiaH567Ye4aBZG25lCLq6UITYAWEPPkTz0aKJkrf+PzridVqZ8RczfER8/vjM2JO0+Ymr@nongnu.org
X-Gm-Message-State: AOJu0YxxW6PSToH3uN1SdpBQ8+Mff6RzPKD99twX2PLyvIeuJR9xlyGq
 lZ28Mnz/+UmJQYZX2hbRSVVtqQ2+O/ryFWD1kLit2JjMFV8e6dv4pI0p5SC8Jp09EhcXVSQ2Iwy
 3stitcDloEB9sbx8C4jzGfy7gJdSr04fuv9fdRgr2isVvsBLZBP9L
X-Received: by 2002:a05:620a:3198:b0:79d:6273:9993 with SMTP id
 af79cd13be357-7a1d697f7bdmr379581085a.6.1722006083241; 
 Fri, 26 Jul 2024 08:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ly8EYZehRi1AfQPvIn5lNouZsIGIWydP3bmenzqwzplQzkcOQA/Dcwqrv6irCxc96RWXgw==
X-Received: by 2002:a05:620a:3198:b0:79d:6273:9993 with SMTP id
 af79cd13be357-7a1d697f7bdmr379577985a.6.1722006082824; 
 Fri, 26 Jul 2024 08:01:22 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d7395b60sm184825285a.21.2024.07.26.08.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jul 2024 08:01:22 -0700 (PDT)
Date: Fri, 26 Jul 2024 11:01:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, sriram.yagnaraman@est.tech,
 mst@redhat.com, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqO6P_Xtjv6Hn_NI@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <CACGkMEuueZsSCRgNvgMXB7Hr0t2xD+EbqgFsF49oUZE8wnBDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuueZsSCRgNvgMXB7Hr0t2xD+EbqgFsF49oUZE8wnBDDA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jul 26, 2024 at 10:12:31AM +0800, Jason Wang wrote:
> On Fri, Jul 26, 2024 at 6:19 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
> > > USO features of virtio-net device depend on kernel ability
> > > to support them, for backward compatibility by default the
> > > features are disabled on 8.0 and earlier.
> > >
> > > Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
> > > Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
> >
> > Looks like this patch broke migration when the VM starts on a host that has
> > USO supported, to another host that doesn't..
> >
> > Yuri, would it be possible we always keep all the USO* features off by
> > default (so this feature bit never affects migration ABI), but then:
> >
> >   - only enable them when the user specified ON
> >
> >   - meanwhile, if detecting host feature doesn't support USO*, it could
> >     fail qemu from boot, rather than silently turning it from ON->OFF
> >
> > ?
> 
> I agree, I have raised the same issue several times in the past.
> 
> >
> > Silently flipping the bit may cause migration issues like this.
> 
> Looking at virtio_net_get_features(), it silently clears a lot of features...

Yes.. :-( I saw that too when looking at this.

Is it because most of those features are supported on most of the kernels,
so we're good until now by chance?  While it looks like e.g. TUN_F_USO4 was
supported only since ~1.5 years ago so it looks relatively new.

Thanks,

-- 
Peter Xu


