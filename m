Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E5BED6D237
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 15:33:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWG03-0007vT-AU; Thu, 18 Dec 2025 10:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWFzy-0007v1-Np
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:33:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vWFzs-0002bb-UZ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 10:33:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766071973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CGWJLaRvWq6Mg8HQOe/YpJmUw0spu3OQSWNTUePXraw=;
 b=Ko+54MfHrZYHTQvkfFj2daW7yOt9tu8i1VMPuS/NRAnImGRRLEu4Pkury2f72Wwe4+lxdz
 3ssoQzU98a/Qlz8/lOoYsGRfGPGTs8Hn7+ft7FNLvMWVP5wz0x70Cy3+aq2edoJPWsXS02
 vfE475DQbfl99ceZ4HG0X0ZJMHy82SU=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-tFhIDZs-NFCbZZlhikSsDw-1; Thu, 18 Dec 2025 10:32:51 -0500
X-MC-Unique: tFhIDZs-NFCbZZlhikSsDw-1
X-Mimecast-MFC-AGG-ID: tFhIDZs-NFCbZZlhikSsDw_1766071971
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8888447ffebso19437756d6.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 07:32:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766071971; x=1766676771; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CGWJLaRvWq6Mg8HQOe/YpJmUw0spu3OQSWNTUePXraw=;
 b=dS5rIh61U+JoyiDlmU5XOVvDo2TVVQHzC+6GR+L2OfZumWZflbTyMqizErywmKL0pk
 Zy7c/ycqWJFPuxUGjBX+t4DMKo5oJcV7Do0rcRLGUbrBWmnZ7VhSrLn5qVXKyr25L87H
 7YHMsaiQChKazYn7Po9QrQL6QDG/iQEIHtj2wyyGGdl3doHjk082B2ym62X4PoMMOoS+
 3BhEAg8TEcns2o+Mzg91F4oMXN/znqodR0vY8SJw2qhu3pxaSiBALohtgnCqtZfSjys+
 WYfwy82tbl7iiRO3ZlZW96DDZECHcQLxbW41IYFC38e2wtIXtm3QyranQn7NMqstVmlo
 BM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766071971; x=1766676771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGWJLaRvWq6Mg8HQOe/YpJmUw0spu3OQSWNTUePXraw=;
 b=e9eYZ5b0PGHsEDxt9JDUFg3BjF1Et/th6Usr8lEuTgqjCVrmM/F/juz0BFBvzBgUW6
 OVsZxYcCUNSOIZBzi2BfkhqSIyRXujR0FS4l93NzlCqWX1yJd2spgga4TXHeXfNOCAE/
 yG3ZqWk6JdKOCNZL6tYdCCuXxeIcuediCY9citxzvTVXbJezmFe0ZY/+fvoPdGuZabWO
 WNkji/MOkZOprSpAOvwiXmB60pepkhTZ2LWFlm6V/yH0+EUU7iqWcDW5AnSqvxNe8BbI
 KOgqWl8B4E9wXYVpQAVHALQjg0MiabVu7WySI2c5JykxieJOiYIZceUanwcrt8rP/J0u
 VFeA==
X-Gm-Message-State: AOJu0YzCcEVQ3euYyexj5Qq48P12FMrajx6SK4xvQkf8hMKdHrJh3xGP
 eEaO23g28ym13UYcyltWDFqBtFxOYSLWe0o7InNPEQpqs1cxOSoZokqZ5/LpCdJyIEVd1XyUHdc
 rFVMikle+A2Bs82yxqNYYlQVgXxroltCXOAn0/E4h3YyaTOskVAC7e7lS
X-Gm-Gg: AY/fxX6B9ahjnIWD2F3GJ0eUZN39ilKKrGYy5IkYoRCOd9Nvx3fWS2CD5/avnrVYEnx
 X+l5jv/tDcvJQLLvLhlnlmtImMQR87ls+iOp/3WfXZK0KkA1I19rlVeF5UrHtQY/BvzAzvUPZWf
 OjljQ6gDvVM9IDvE3kyF6AlsMGf5AH71xyuEM0FbG2rq8baPgmGv5HX5By4ljzrmxRyriu3Jw8T
 BZo2MeJ2xafUmZnehcifBYFgz9cB3ZFRTaB+1lZvpv0VLTl/wPDRI1wDKTMUs1gwVg29GDJFUqk
 Acyo+LVwyevBr69mWrWtaTPIzzJ8I1KdOSlE9lB7gwqkC0RF2nBOCz2nFKzEnnY8H/NC4dczx4Q
 DFDQ=
X-Received: by 2002:a05:6214:5003:b0:880:45ad:3db3 with SMTP id
 6a1803df08f44-8887e16b3bdmr341785486d6.51.1766071970718; 
 Thu, 18 Dec 2025 07:32:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE597p4z+i+Xj3uQon/KO//kc9qyjgnVRPzlHqa+FUGJqg8eGOrmlT5JckQpMT4P5cR0LzYZg==
X-Received: by 2002:a05:6214:5003:b0:880:45ad:3db3 with SMTP id
 6a1803df08f44-8887e16b3bdmr341784586d6.51.1766071969983; 
 Thu, 18 Dec 2025 07:32:49 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88c6166ff89sm19611996d6.53.2025.12.18.07.32.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Dec 2025 07:32:49 -0800 (PST)
Date: Thu, 18 Dec 2025 10:32:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Chuang Xu <xuchuangxclwt@bytedance.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, mst@redhat.com,
 sgarzare@redhat.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, david@kernel.org, philmd@linaro.org
Subject: Re: [PATCH v3 1/1] migration: merge fragmented clear_dirty ioctls
Message-ID: <aUQeoNveybyICXjD@x1.local>
References: <20251216080001.64579-1-xuchuangxclwt@bytedance.com>
 <877bum36ed.fsf@suse.de> <aUGIPj1JNpd8HZ-V@x1.local>
 <29bc82b4-99c3-4275-b4a8-cfc400f0e44d@bytedance.com>
 <aUKuWISfpQeld_AF@x1.local>
 <65dc5a3d-fe3f-48d9-b7e8-c04346308fa8@bytedance.com>
 <aULFP1kbeT2yceiV@x1.local>
 <82ca276d-831d-4e19-96e2-d88a7f94a430@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <82ca276d-831d-4e19-96e2-d88a7f94a430@bytedance.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Dec 18, 2025 at 05:20:19PM +0800, Chuang Xu wrote:
> On 17/12/2025 22:59, Peter Xu wrote:
> > Right, it will, because any time used for sync has the vCPUs running, so
> > that will contributes to the total dirtied pages, hence partly increase D,
> > as you pointed out.
> >
> > But my point is, if you _really_ have R=B all right, you should e.g. on a
> > 10Gbps NIC seeing R~=10Gbps.  If R is not wire speed, it means the R is not
> > really correctly measured..
> 
> In my experience, the bandwidth of live migration usually doesn't reach
> the nic's bandwidth limit (my test environment's nic bandwidth limit is 200Gbps).
> This could be due to various reasons: for example, the live migration main thread's
> ability to search for dirty pages may have reached a bottleneck;
> the nic's interrupt binding range might limit the softirq's processing capacity;
> there might be too few multifd threads; or there might be overhead in synchronizing
> between the live migration main thread and the multifd thread.

Exactly, especially when you have 200Gbps NICs.

I hope I have some of those for testing too!  I don't, so I can't provide
really useful input..  My vague memory (I got some chance using a 100Gbps
NIC, if I recall correctly) is that main thread will bottleneck already
there, where I should have (maybe?) 8 multifd threads.

I just never knew whether we need to scale it out yet so far, normally
100G/200G setup only happens with direct attached, not a major use case for
cluster setup?  Or maybe I am outdated?

If that'll be a major use case at some point, and if main thread is the
bottleneck distributing things, then we need to scale it out.  I think it's
doable.

> 
> >
> > I think it's likely impossible to measure the correct R so that it'll equal
> > to B, however IMHO we can still think about something that makes the R
> > getting much closer to B, then when normally y is a constant (default
> > 300ms, for example) it'll start to converge where it used to not be able to.
> 
> Yes, there are always various factors that can cause measurement errors.
> We can only try to make the calculated value as close as possible to the actual value.
> 
> > E.g. QEMU can currently report R as low as 10Mbps even if on 10Gbps, IMHO
> > it'll be much better and start solving a lot of such problems if it can
> > start to report at least a few Gbps based on all kinds of methods
> > (e.g. excluding sync, as you experimented), then even if it's not reporting
> > 10Gbps it'll help.
> >
> After I applied these optimizations, typically the bandwidth statistics
> from QEMU and the real-time nic bandwidth monitored by atop are close.
> 
> Those extremely low bandwidth(but consistent with atop monitoring) is usually
> caused by zero pages or dirty pages with extremely high compression rates.
> In these cases, QEMU uses very little nic bandwidth to transmit a large number
> of dirty pages, but the bandwidth is only calculated based on the actual
> amount of data transmitted.

Yes.  That's a major issue in QEMU, zero page / compressed page / ... not
only affects how QEMU "measures" the mbps, but also affects how QEMU
decides when to converge: here I'm not talking about the bw difference
causing "bw * downtime_limit" [A] too small.  I'm talking about the other
side of equation where we used [A] to compare with "remain_dirty_pages *
psize" [B].  In reality, [B] isn't accurate either when zero page /
compressed page / ... is used..

Maybe.. the switchover decision shouldn't be MBps as unit, but "number of
pages".  It'll remove most of those effects at least, but that needs some
more considerations..

> 
> If we want to use the actual number of dirty pages transmitted to calculate
> bandwidth, we face another risk: if the dirty pages transmitted before the
> downtime have a high compression ratio, and the dirty pages to be transmitted
> after the downtime have a low compression ratio, then the downtime will far
> exceed expectations.

... like what you mentioned here will also be an issue if we switch to use
n_pages to do the math. :)

> 
> This may have strayed a bit, but just providing some potentially useful information
> from my perspective.

Not really; patch alone is good, I appreciate the discussions.

Thanks,

-- 
Peter Xu


