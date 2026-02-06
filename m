Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7AFEE20A0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 13:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voLvc-0004fv-67; Fri, 06 Feb 2026 08:31:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voLvX-0004fb-L5
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:31:15 -0500
Received: from mail-qv1-xf36.google.com ([2607:f8b0:4864:20::f36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1voLvW-0007jt-7D
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 08:31:15 -0500
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-895075a3be1so23722706d6.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 05:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1770384673; x=1770989473; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Di9rrCemg3Phd+bFA7xXmyQkZ2Pz85YWhx7g/X7oYx4=;
 b=Sd679ui/OpLFa2hFD5k8g7KVCVHw42LAEKnSr1mqQs6pgswstyRcx+83XBm+tATqzn
 d/dkgCcUebZ57N3vza1r+N+7SmqAQZFgJXAh1aTT/Wp3urS3xB6ukvstpDfp4m2FnGLJ
 eCbb+tz9T31t/h9kfXfC+Ef3pRQZ4lU48eeI0psht2NO92rOHdNNA07vmVFWLRb4XytY
 X35GPxbDXgEhM6o6mrFc6HMngOcbVW802YcVKn/RBcmT6xcrP1cjgWSHl9L0npAge7fb
 mIEONIqoZw7nsX+nfyTTbgad/Fio9INNE4HOfnraHDMxKnWjiFLEw3SeLKCMy+v1VApk
 A9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770384673; x=1770989473;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Di9rrCemg3Phd+bFA7xXmyQkZ2Pz85YWhx7g/X7oYx4=;
 b=xHaFzbjACaO6xe+uTpyMVqtlhNsxpqVYif6u1FKqT0oBf6VQrsDkBrmxbZa49b1qtf
 GyFGtbqXBM3Xp3pmDgcX51p/7QsI0KovNu9T3LTQM26Bng2meNRN0FiCQreuFrtDhUBQ
 QzWeNvDoSVTfuCMG/iDwX6IrHXiKSuxJuGu2DMFac2tKtnDDW6MJMjZ1pULTOza4ffh3
 S9d6RypskBM4Je8VzhZy9m37xz5guy4jGJkkzL+++GOxrV19SnYSG940bWjovoI3Qo1U
 6LjNd3p/Aymdi5w6j4reaSPupS17Uspru2yz2EKvmNXTcChHAI4SvJH2aQb8mI39tuA8
 326g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVT+kqXYNgK2E/IHPT1pmftOEdQhXsJ6k+zw+6dkzZ8OoHM1j0NWSGNJzmb5noz0nWBrUU7lMUZmrqY@nongnu.org
X-Gm-Message-State: AOJu0YwomOdszptIbeC1ck1tCIBVE9dfcu5SwHmPU9zYpx7Un3U8GeJF
 c4zc0HnDSONWcnpGj53OnBZhKqNfSGWRohNn6oTtkbbspfR+iDVVxJNfAnQE/lC6ARo=
X-Gm-Gg: AZuq6aLNVytKifJPn84HhyLRiN+TnMYqijgEThg522ciowgN1Y30412b9fpSZtSKn9b
 Hk/bNjndGzPbdUVHpGXRaf1B4PFV6am7E/JwcoLebT/aLZPIn3PltbEDtA8/1j0INRSjzFBr7/8
 n2XHfkMpmxEuvvfn1cbYDgnwkyeZKW8Z3dpaNNamnhitbmc1J4T+VSMm5OuwDPFgfwBKEY0KY+X
 nfGsM4gLUxusOCivcyZl7fi8uFwpWdiP9689PRPVKqBlHm3VFzwA1BGnR5wF+3XZ6EK34NZYBeI
 TbnOWTlXD+139+73hvkLBMMCiLjpfTPwhRibomgZh058+Mw8vpGcoKM5MAS/L6ztKD3PDrTs00x
 G/Mtyo6ZAQgxkvxeTgFggxmOHMkuJrIEc1QWTws8ldNvoUUJGOpbPfogrHHeHAnISM6Qt9P5uHX
 3uYTIoZ4l+6FYT04Jox/oqzmqv7DaG9Mjn+d8reIdniVzT8M/Bw3pTD4OSVYFG1pi4wITYhA==
X-Received: by 2002:a05:6214:2428:b0:894:6540:9112 with SMTP id
 6a1803df08f44-8953c150d50mr35637556d6.33.1770384672493; 
 Fri, 06 Feb 2026 05:31:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F
 (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8caf9ee9fbasm152145985a.39.2026.02.06.05.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 05:31:11 -0800 (PST)
Date: Fri, 6 Feb 2026 08:31:09 -0500
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Cui Chao <cuichao1753@phytium.com.cn>, dan.j.williams@intel.com,
 Mike Rapoport <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] mm: numa_memblks: Identify the accurate NUMA ID
 of CFMW
Message-ID: <aYXtHa4Y2y_5xgcS@gourry-fedora-PF4VCD3F>
References: <20260108094812.8757ce3ad8370668eaafb29c@linux-foundation.org>
 <9132054c-3017-4af0-84e0-e4359b0794a6@phytium.com.cn>
 <20260115101858.85fd7b8e837c1c92a4fdc5f0@linux-foundation.org>
 <696944eca1837_34d2a10056@dwillia2-mobl4.notmuch>
 <2d1e23ad-7ec1-483b-88b3-70ce19b69106@phytium.com.cn>
 <aXOl9CN_66HywIjZ@gourry-fedora-PF4VCD3F>
 <a90bc6f2-105c-4ffc-99d9-4fa5eaa79c45@phytium.com.cn>
 <20260205145842.efb90572a902ae4c481e6ef6@linux-foundation.org>
 <aYUjf0OrD8f_bJCy@gourry-fedora-PF4VCD3F>
 <20260206110305.00001fbb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260206110305.00001fbb@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f36;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Feb 06, 2026 at 11:03:05AM +0000, Jonathan Cameron wrote:
> On Thu, 5 Feb 2026 18:10:55 -0500
> Gregory Price <gourry@gourry.net> wrote:
> 
> I disagree. There is nothing in the specification to say it should do that and
> we have very intentionally not done so in QEMU - this is far from the first
> time this has come up!. We won't be doing so any time soon unless someone
> convinces me with clear spec references and tight reasoning for why it is the
> right thing to do.
> 

Interestingly I've had this exact conversation - in reverse - with other
platform folks, who think CFMWS w/o SRAT is broken.  It was a zealous
enough opinion that I may have over-indexed on it (plus i've read the
numa mapping code and making this more dynamic seems difficult).

> This configuration reflects the pre hotplug / early CXL deployment
> situation. Now we have proper support in Linux we have moved beyond that.
> We do need to solve the dynamic NUMA node cases though and I'm hoping your
> current work will make that a bit easier.

If we want flexibility to ship HPAs around to different nodes at
runtime, that might cause issues. The page-to-nid / pa-to-nid mapping
code is somewhat expected to be immutable after __init, so there could
be nasty assumptions sprinkled all over the kernel.

That will take some time.
---

Andrew if Jonathan is good with it then with changelog updates this can
go in, otherwise I don't think this warrants a backport or anything.

~Gregory

