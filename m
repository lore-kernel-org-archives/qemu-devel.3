Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0955BD41D64
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 17:15:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkFo-0007G8-6L; Thu, 11 Dec 2025 12:15:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTkFm-0007Fl-1Q
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 12:14:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTkFi-00078t-3R
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 12:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765473293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEqWQEyYFuEdzE04pj0XZ+07AWt2Zt6gbi8uTwHguvs=;
 b=EjWbV+Sa9KvnQFwyS5xCCzfurorngMBg2kSONBlCh2ETJzvyo/+6j5k9prMtx58S3OHf3C
 DLhGoRGp37QdQHXkT1pk9lwmyIUr92/l2GYf3LFuXCYegqzi5qUy3/hzh08tZAV9JLzMtG
 3sQJwz/ZBaUYNcAXaHsAKPkAQClDcjo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619--33puKOJOqSTXNmERNwnXQ-1; Thu, 11 Dec 2025 12:14:51 -0500
X-MC-Unique: -33puKOJOqSTXNmERNwnXQ-1
X-Mimecast-MFC-AGG-ID: -33puKOJOqSTXNmERNwnXQ_1765473291
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8ba026720eeso63438585a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765473291; x=1766078091; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lEqWQEyYFuEdzE04pj0XZ+07AWt2Zt6gbi8uTwHguvs=;
 b=A0lU0/IJNqd7RukcmrR0jMY+CL8CGoCgQ7TiZDg/0lh1R7YgPqfLLvd/wCaND2XGad
 Nzl02PwOZj/7d0/7UrRezwChujjZzwsSwRwC0wZR1xlnBqJVAg4m/idaFFP6ydYo9mlz
 Xj86vvlhC5fbYatUzjlp8FHQB71Uv78vKF05gZt08wUGxohY7AQuRH9cBrqqXf1dwuHi
 d6luQ7Ko0XHOQ8nj1lvbk7gsb+vMBb69QotIq9wvxTyiIAfIXosDiGPEFcSIwQGeQzrl
 dsd1lgKtAED9gS6lBtUQHGamywGuI7WHKKxMmnSMFY02Ohl0ZKGqc0QyxMeSG4OQ0TFy
 rY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765473291; x=1766078091;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lEqWQEyYFuEdzE04pj0XZ+07AWt2Zt6gbi8uTwHguvs=;
 b=iJf478BAkYol0QQVCtzbOe02B9VVd2jN8rUaTsGloK2cXTOlZWtuP4nGnVu70SJ+5w
 ZCNB760jtOK2cpsbUmtGGJHsWVGtowHkY22ifIkAIeg+K+B85AwezuVPl5OOHhFoQlvi
 Sir2bVFvoSPulDy5Ejfoov16H0/ZyPpk9HaEncQId26he3WGGBIadZmUp+liiLdt9F9c
 n4OTK+iQwTGUPjnfsEmGswq8pZGChEBEeokcTfkBV5rrp8R25GTZ9jXLY+cph8chAyKg
 d2C+smUm3oqomy1qS692gawH2LJFe4EZdxQgYE6cT17xkgkWe8rDeGRNSACBz2vkTLWl
 1nOQ==
X-Gm-Message-State: AOJu0YyZ1mamQNFUvsuVaK99SUGO2sFhtVXk7zjmXl64Ktjy18qBu4E/
 KvEVxtl7Bl7H22SWcsihOp7XXORR0W3esK+RpDr568VDodOddc02OKx8qsYUWpVUPwceCbBUpmC
 7dhJ/d2RqxBZFS61CviIXYkPKdtO/P2OfqG3nd+YvHjaa+lDPhKvOGmeT
X-Gm-Gg: AY/fxX68maWAhF1xlVUUikG3FArzXJSti98mnXKsiuBxUSeGhprS7dvGaJUIAQJcrzt
 /+x1ORn5j260S+hvUSxfTk5A9+517ern7xuySKsMVwcqbq+ORg0fd7kK0bz8jXXUb9YXERUHaAC
 RoCBC7BqtvdxBMTBBlJyH8FZvYwZgeLMSpOhIKWoRJag40BjS2+kPPqBzizds7ojlDXJuWPoIQL
 WzzM0agHLweaJSfpapiLQalLU4G8zha0TZotpCZBYNO+rOO7e7QpAEilWzORVaFL76LfLSUPRXm
 w8QNkpRCKeMVFLUo6cewe0eZD1C4Jh4ADTBAJdgHTxi2as6F8wt9HdKxSSAxD7H6p/ULB9E5sV/
 ytpM=
X-Received: by 2002:a05:620a:460d:b0:8a2:6690:2417 with SMTP id
 af79cd13be357-8ba3a66684cmr972396485a.67.1765473291330; 
 Thu, 11 Dec 2025 09:14:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE1lFDMTI4Jfso9RNEEq2ftqmmlEdk8hMrGFyQpUU8t8s9bgl580iQvP4Ph2VC7QnIyPWI/Fw==
X-Received: by 2002:a05:620a:460d:b0:8a2:6690:2417 with SMTP id
 af79cd13be357-8ba3a66684cmr972391185a.67.1765473290864; 
 Thu, 11 Dec 2025 09:14:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8bab5d4d24bsm279549085a.50.2025.12.11.09.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 09:14:50 -0800 (PST)
Date: Thu, 11 Dec 2025 12:14:48 -0500
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
Message-ID: <aTr8CDd1vBuOIx_B@x1.local>
References: <20251209162857.857593-1-peterx@redhat.com>
 <ab8ac8e1-b371-410d-88da-21e93a5985b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab8ac8e1-b371-410d-88da-21e93a5985b0@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Dec 11, 2025 at 05:29:37PM +0100, Cédric Le Goater wrote:
> On 12/9/25 17:28, Peter Xu wrote:
> > [This is an RFC series, as being marked out.  It is trying to collect
> >   opinions.  It's not for merging yet]
> > 
> > Background
> > ==========
> > 
> > It all starts with machine compat properties..
> > 
> > Machine compat properties are the major weapon we use currently in QEMU to
> > define a proper guest ABI, so that whenever we migration a VM instance from
> > whatever QEMU version1 to another QEMU version2, as long as the machine
> > type is the same, logically the ABI is guaranteed, and migration should
> > succeed.  If it didn't, it's a bug.
> 
> On the PPC pseries machines, we had to introduce a capability concept
> and infrastructure on top of the machine versions to handle cases where
> the features advertised to the guest (also visible to the OS) could
> differ from one host to another and generate migration errors. See :
> 
>   hw/ppc/spapr_caps.c
> 
> These capabilities can be tweaked on the command line to adjust source
> and target host support. It's mostly related to CPU and MM features.
> Initially these difference were related to CPU bugs IIRC and different
> FW levels on the host.
> 
> Is your proposal doing something similar ? Is my understanding correct ?

Maybe not exactly.

I only roughly read through SPAPR_CAP_HTM as an example, please help double
check if I misread it - I think such falls more into what Dan mentioned on
query-platform.

I am guessing CPU class of other archs should use similar concept, but I'm
not familiar with how it was done right now with QEMU/Libvirt.

So we have two standard categories of problems:

  (1) A new feature, the feature should almost always be enabled on new
      QEMUs, but need to be kept disabled when it can be migrated from old
      QEMUs.  It has nothing to do with the host / platform.

  (2) A new feature, the feature should normally be enabled only whenever
      the host HW/kernel supports it.

This series should try to solve problem (1) on non-qdev objects; it was
working properly for TYPE_DEVICE even before this series.  It doesn't yet
solve problem (2).  Problem (2), as a generic approach, may need something
like query-platform as Dan used to suggest.

IIUC all the spapr caps will still be needed, and I believe Libvirt knows
how to query caps in this case for spapr. It's a matter of if we should
have an unified interface to probe all of host capabilities, which should
not only include things like kvmppc_has_cap_htm(), but all the rest
platform info like TAP USO supports, in one batch to Libvirt. So Libvirt
takes it as "host information", plus user decisions to further decide the
QEMU cmdlines (or QMP commands used to create the system emulation).
That'll also include the -M cap-htm=XX properties to be used.

Considering that we should have ways Libvirt probing these.. maybe we do
not need to merge everything into a new QMP query-platform, but we can
consider putting all the new host info into that one command from now on.

Thanks,

-- 
Peter Xu


