Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CD5CF2599
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 08:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLdEN-0005Yf-U7; Wed, 19 Nov 2025 03:07:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vLdEJ-0005YP-UP
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:07:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vLdEI-0005xb-HI
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 03:07:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763539673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GCDX9C4ls3wvv3mPEMBqvdGOvBYwIviD3MU7a88O3/s=;
 b=V47XxNgXBVMBpKkVasmLeVxSqbozGz2s5J8xCU6SCMCofhPUFcpmmG7NMgTMGM+vZHiLZC
 FurHkq3uvhG62F8sljBiTAEP9qwCWi2A33nnTrAcEwKF4LkpOIgByYdZo4KFHmshCkSgWk
 y0Rt0JlDW5jQTzLZH50OBbTi5vGY4Ds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-688-gLSl3KlOMN6THXra7vUwIg-1; Wed, 19 Nov 2025 03:07:51 -0500
X-MC-Unique: gLSl3KlOMN6THXra7vUwIg-1
X-Mimecast-MFC-AGG-ID: gLSl3KlOMN6THXra7vUwIg_1763539671
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42b2b642287so3728057f8f.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 00:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763539670; x=1764144470; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GCDX9C4ls3wvv3mPEMBqvdGOvBYwIviD3MU7a88O3/s=;
 b=g6FjAQSQm9CHCmMm4s7AknELR7fC6nfI5mr5BVDHqWCCQ/hGw9VFheHuxlKWjSWfXD
 gM2Pv4XppWUhGIEsp0QcDypfCpDr3gj415jWzMrhfQ0copJAWgHyjxIYlCnrMUmIVBeN
 7cSUTGhf5o3yvSHmxfD4Zaq1U+wwnQXkrj1X1FKq/ZYlyNHATT/1mMvNnHx6Hgk1kQuy
 145vzdPZWOZhTJFBZW3puhhAhHg8YpkL3FHM21iqTm1AIdkZmH5q8ZRV15pJBEra94bQ
 FoA62A+xSl9WGuT+gF2whyUot7DrGMtJNM/JkrpuAsUNlCZ3O7VDFYzTvsw+Qj+x9aFe
 khyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763539670; x=1764144470;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GCDX9C4ls3wvv3mPEMBqvdGOvBYwIviD3MU7a88O3/s=;
 b=M3DkAbmTFV4LKTsxMk5PCni1oE9KiGE4QysUBtj7FRxnCLMXYES+D9BupaHthyyDsh
 bvwIDRXdloi4e7e3HtaK6MoeQ+PGFOpCD+seF0nq6PdzYpC+cZNgxcgGF642UAbYKcMC
 xWUFNN+ze3CpWglVO1iXUzET9+90P8EV5m8DwN5AHMxWZPhLtW9CD1cZTnkN7G907s1w
 oqmqx7ko2v6NyB/X7SO1m/JneJMNZwclbAWk6D6t/D//MupkEI3vE5KoWKn+12Ixg41t
 keIlLqdp5a9d9sZVt8WbC20LHKu7I2rCVNHk4gt3ue3wnjifaedLA/985aj3oXfTOJPd
 QcmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaPyKV1rWLn65VSdi9w4PQ98drELIfBJUcC0y58j/cZgTDaygow01pbK0C1BrHhHz6klcNydS4jtXE@nongnu.org
X-Gm-Message-State: AOJu0YwSEu1E1D7++Uc228GjICRisxDEKLbzvCIB6un9xzFVfG41yXAg
 9Rh0t2FiMbUNxpQvwCtrxxXC29naLNYjr00Pb9a/7AFwT8FoOarvcg8gq6d3Q6QBhJydiRsoaP1
 aMEbyPEwj3xgi7AshotG/ym+hhLvCZLK1guw9bVGC93aqZTd1JQGqN89s
X-Gm-Gg: ASbGncuPElzRS46E8gqqwoBSYPbdayblgcqFw5legrjWO2PAstc9dOTZiLD74to7Xs+
 BqNY2y0ZodoxJ6Y3NIqcknnfq1plLRuNBVKesyngbQkbKGtYQszy4QGQpq/39prXny+Vq0L8gDQ
 xtrH/AJwMQPm5CkVnd0weu9UltE2tllWVlcttv7d8SQeGixPgQ1cNouFAogQjUxPA8d8pZOaQUs
 dZLoG1Zxrx3nIStZgFH5X0TkrZ6gBdadY6NMqGZryo2r710ZfkjLmj8O0daT35HF55D+QncwbsZ
 Fawfc7OhdBN4LFJs1NGWhK461KGatHoraR48xCJBkJZxmTDgKobNqZ/7L6ng/AmIfErv6WQNDoR
 RRTwVl3HRI3FLtfDLusDdNgLR5o/kKQ==
X-Received: by 2002:a05:6000:2806:b0:42b:4061:23f3 with SMTP id
 ffacd0b85a97d-42b5938886amr12615627f8f.44.1763539670385; 
 Wed, 19 Nov 2025 00:07:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGFyQ3RARJzk8yDRlOMfvNhN3VSPYQ0TkGkXusXZwkPBdnC+Iv7KFQrD+99EDs8kIMKqdQ+9A==
X-Received: by 2002:a05:6000:2806:b0:42b:4061:23f3 with SMTP id
 ffacd0b85a97d-42b5938886amr12615602f8f.44.1763539669844; 
 Wed, 19 Nov 2025 00:07:49 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e84b12sm38180733f8f.15.2025.11.19.00.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Nov 2025 00:07:49 -0800 (PST)
Date: Wed, 19 Nov 2025 03:07:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, zhao1.liu@intel.com, qemu-devel@nongnu.org,
 farosas@suse.de, jinpu.wang@ionos.com, thuth@redhat.com,
 berrange@redhat.com
Subject: Re: [RFC PATCH] virtio-net: introduce strict peer feature check
Message-ID: <20251119030622-mutt-send-email-mst@kernel.org>
References: <20251113110004-mutt-send-email-mst@kernel.org>
 <aRYJRZyNrDcDzTuG@x1.local>
 <20251113114710-mutt-send-email-mst@kernel.org>
 <aRYRhg7lKDCBUIrf@x1.local>
 <20251113124207-mutt-send-email-mst@kernel.org>
 <CACGkMEtdxWJygVbcuvER5yj13R0JL_bxPSAg0eYyiBeh=SyRXg@mail.gmail.com>
 <20251116014625-mutt-send-email-mst@kernel.org>
 <CACGkMEsxZvzyeqa_-9qQRfwNGAeCg5pLgu5MtEHr0OFWpA4_-g@mail.gmail.com>
 <20251117034940-mutt-send-email-mst@kernel.org>
 <CACGkMEsxTSG66StYpkStDqqJJmcTOSLjLH9DzNQ9WN=ffsUkDw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsxTSG66StYpkStDqqJJmcTOSLjLH9DzNQ9WN=ffsUkDw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 19, 2025 at 10:49:11AM +0800, Jason Wang wrote:
> > qemu already probes tap features.
> 
> Only part of the features.


the part we care about?

> > To me, it seems natural
> > for management to do the probing through qemu.
> > in fact your patch is a way to do that, is it not?
> 
> Yes and no.
> 
> > what it lacks though is a structured way to tell management how
> > to fix the problem.
> 
> Probing through management seems to be better. For example it can
> calculate the cluster in advance without the need to launch qemu
> everywhere.

it is basically replicating qemu code then.

what's the big deal to launch qemu?



> Or consider the case when USO is not supported by the kernel in the
> destination, even if qemu reports this, I'm not sure what is expected
> to be done in the management layer?
> 
> Thanks

reports what?

-- 
MST


