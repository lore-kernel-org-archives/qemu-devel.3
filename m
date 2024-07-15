Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D482C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 14:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTMvL-00045I-B9; Mon, 15 Jul 2024 10:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTMvK-00044Q-8t
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sTMvI-0001nL-7k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 10:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721054605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MyiWcjy1J0tBPw0fqykkUUFq/D1LWGh95VOzE+IZvpY=;
 b=GG48SWygG8YvzwXO7qmq0NRPcsXhAFiEAsz43fsF674Hp7AQYwSmGYkFU6sEw7V6+RB0a7
 1qNpjnJ8bwLZ9xf/ABQcXadpXL1D61hPMNzc1+scV1FS1sKPiZFoK42opGG9z/fnsJCKzE
 Qkhx5Muq99B3iQy0KbcVs/TGv953dMA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-2EhY7f0LP86qNt4K0ekKYQ-1; Mon, 15 Jul 2024 10:43:24 -0400
X-MC-Unique: 2EhY7f0LP86qNt4K0ekKYQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-367960f4673so2966664f8f.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2024 07:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721054603; x=1721659403;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MyiWcjy1J0tBPw0fqykkUUFq/D1LWGh95VOzE+IZvpY=;
 b=X2i2c3qs82WwJwymINzvE74I8gis6wsbuh/qF5a+2QVk6mehpyPI0S4YiLGpA6TfxW
 oP2ikvKtCXFfnmFGRxUwoUvlANkCaO1Z5RDy7g/2QGBRQvaD3iyWX1KuaFbTui41kVdt
 UvtolmoZ8xe6Je6zGeve0xewQO3FHgBd5ZWQylitauzLLNM87mV+WsSHL0RLl70VdAoK
 3lSYrGeA2HQgN0nYocxB7KHRDCnqIC8t55XXUQ2ruf8tIQn0kxYLV9d1/aMilTmceHeo
 /BCEaHU1A2dEcT2GG2l5FqFIJhjiVVmhg0WUnKB4Uz30tF6NMfWgso08xIT71T740K6P
 vPBg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO1tkiAtB9tcRNDMBYy2EWaRCo52IaFS9g+eP5JSsJ9jxgGVKwbmsnEbFA2VWPRDEpkRx29XuV2pRFBxSkGhe+FL0Lzco=
X-Gm-Message-State: AOJu0YxozieEw11frAhaQqfn4u+8E9jiChXKvNf2QS4AYWRViLQ6zOU9
 aGlvAUu0SubUFpgFmqXzRz4+w4MNakZXnSbiMkAb6mm3lAoYKmnn+76X3Zg8oC070c4PSlFoD8l
 cCyuHPPMVKtTiL5hAJPWa3pQDzvAbaCtsOE8UFskGbek7rZ3JkTWE
X-Received: by 2002:a5d:6dc4:0:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-367ff6edd0amr8215245f8f.11.1721054602989; 
 Mon, 15 Jul 2024 07:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0138J1NAVK32E0DlyX4TF2ohXNBVeXb7jik4+U72kBKBQ0Vy7nQ+YELA7mXFohFw5CZrnzQ==
X-Received: by 2002:a5d:6dc4:0:b0:367:895f:619e with SMTP id
 ffacd0b85a97d-367ff6edd0amr8215211f8f.11.1721054602359; 
 Mon, 15 Jul 2024 07:43:22 -0700 (PDT)
Received: from redhat.com ([2.52.29.159]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb478sm90804925e9.33.2024.07.15.07.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jul 2024 07:43:21 -0700 (PDT)
Date: Mon, 15 Jul 2024 10:42:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>,
 "Kumar, Shivam" <shivam.kumar1@nutanix.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload zero
 page checking in multifd live migration.
Message-ID: <20240715104015-mutt-send-email-mst@kernel.org>
References: <20240711215244.19237-1-yichen.wang@bytedance.com>
 <20240711184131-mutt-send-email-mst@kernel.org>
 <PH7PR11MB594105D464F3A4C2C25F94FEA3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
 <20240715081857-mutt-send-email-mst@kernel.org>
 <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941A453AC1A4B3A387475A7A3A12@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jul 15, 2024 at 01:09:59PM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, July 15, 2024 8:24 PM
> > To: Liu, Yuan1 <yuan1.liu@intel.com>
> > Cc: Wang, Yichen <yichen.wang@bytedance.com>; Paolo Bonzini
> > <pbonzini@redhat.com>; Marc-André Lureau <marcandre.lureau@redhat.com>;
> > Daniel P. Berrangé <berrange@redhat.com>; Thomas Huth <thuth@redhat.com>;
> > Philippe Mathieu-Daudé <philmd@linaro.org>; Peter Xu <peterx@redhat.com>;
> > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Kumar, Shivam
> > <shivam.kumar1@nutanix.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>
> > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to offload
> > zero page checking in multifd live migration.
> > 
> > On Mon, Jul 15, 2024 at 08:29:03AM +0000, Liu, Yuan1 wrote:
> > > > -----Original Message-----
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Friday, July 12, 2024 6:49 AM
> > > > To: Wang, Yichen <yichen.wang@bytedance.com>
> > > > Cc: Paolo Bonzini <pbonzini@redhat.com>; Marc-André Lureau
> > > > <marcandre.lureau@redhat.com>; Daniel P. Berrangé
> > <berrange@redhat.com>;
> > > > Thomas Huth <thuth@redhat.com>; Philippe Mathieu-Daudé
> > > > <philmd@linaro.org>; Peter Xu <peterx@redhat.com>; Fabiano Rosas
> > > > <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus Armbruster
> > > > <armbru@redhat.com>; Cornelia Huck <cohuck@redhat.com>; qemu-
> > > > devel@nongnu.org; Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1
> > > > <yuan1.liu@intel.com>; Kumar, Shivam <shivam.kumar1@nutanix.com>; Ho-
> > Ren
> > > > (Jack) Chuang <horenchuang@bytedance.com>
> > > > Subject: Re: [PATCH v5 00/13] WIP: Use Intel DSA accelerator to
> > offload
> > > > zero page checking in multifd live migration.
> > > >
> > > > On Thu, Jul 11, 2024 at 02:52:35PM -0700, Yichen Wang wrote:
> > > > > * Performance:
> > > > >
> > > > > We use two Intel 4th generation Xeon servers for testing.
> > > > >
> > > > > Architecture:        x86_64
> > > > > CPU(s):              192
> > > > > Thread(s) per core:  2
> > > > > Core(s) per socket:  48
> > > > > Socket(s):           2
> > > > > NUMA node(s):        2
> > > > > Vendor ID:           GenuineIntel
> > > > > CPU family:          6
> > > > > Model:               143
> > > > > Model name:          Intel(R) Xeon(R) Platinum 8457C
> > > > > Stepping:            8
> > > > > CPU MHz:             2538.624
> > > > > CPU max MHz:         3800.0000
> > > > > CPU min MHz:         800.0000
> > > > >
> > > > > We perform multifd live migration with below setup:
> > > > > 1. VM has 100GB memory.
> > > > > 2. Use the new migration option multifd-set-normal-page-ratio to
> > control
> > > > the total
> > > > > size of the payload sent over the network.
> > > > > 3. Use 8 multifd channels.
> > > > > 4. Use tcp for live migration.
> > > > > 4. Use CPU to perform zero page checking as the baseline.
> > > > > 5. Use one DSA device to offload zero page checking to compare with
> > the
> > > > baseline.
> > > > > 6. Use "perf sched record" and "perf sched timehist" to analyze CPU
> > > > usage.
> > > > >
> > > > > A) Scenario 1: 50% (50GB) normal pages on an 100GB vm.
> > > > >
> > > > > 	CPU usage
> > > > >
> > > > > 	|---------------|---------------|---------------|-------------
> > --|
> > > > > 	|		|comm		|runtime(msec)	|totaltime(msec)|
> > > > > 	|---------------|---------------|---------------|-------------
> > --|
> > > > > 	|Baseline	|live_migration	|5657.58	|		|
> > > > > 	|		|multifdsend_0	|3931.563	|		|
> > > > > 	|		|multifdsend_1	|4405.273	|		|
> > > > > 	|		|multifdsend_2	|3941.968	|		|
> > > > > 	|		|multifdsend_3	|5032.975	|		|
> > > > > 	|		|multifdsend_4	|4533.865	|		|
> > > > > 	|		|multifdsend_5	|4530.461	|		|
> > > > > 	|		|multifdsend_6	|5171.916	|		|
> > > > > 	|		|multifdsend_7	|4722.769	|41922		|
> > > > > 	|---------------|---------------|---------------|-------------
> > --|
> > > > > 	|DSA		|live_migration	|6129.168	|		|
> > > > > 	|		|multifdsend_0	|2954.717	|		|
> > > > > 	|		|multifdsend_1	|2766.359	|		|
> > > > > 	|		|multifdsend_2	|2853.519	|		|
> > > > > 	|		|multifdsend_3	|2740.717	|		|
> > > > > 	|		|multifdsend_4	|2824.169	|		|
> > > > > 	|		|multifdsend_5	|2966.908	|		|
> > > > > 	|		|multifdsend_6	|2611.137	|		|
> > > > > 	|		|multifdsend_7	|3114.732	|		|
> > > > > 	|		|dsa_completion	|3612.564	|32568		|
> > > > > 	|---------------|---------------|---------------|-------------
> > --|
> > > > >
> > > > > Baseline total runtime is calculated by adding up all multifdsend_X
> > > > > and live_migration threads runtime. DSA offloading total runtime is
> > > > > calculated by adding up all multifdsend_X, live_migration and
> > > > > dsa_completion threads runtime. 41922 msec VS 32568 msec runtime and
> > > > > that is 23% total CPU usage savings.
> > > >
> > > >
> > > > Here the DSA was mostly idle.
> > > >
> > > > Sounds good but a question: what if several qemu instances are
> > > > migrated in parallel?
> > > >
> > > > Some accelerators tend to basically stall if several tasks
> > > > are trying to use them at the same time.
> > > >
> > > > Where is the boundary here?
> > >
> > > A DSA device can be assigned to multiple Qemu instances.
> > > The DSA resource used by each process is called a work queue, each DSA
> > > device can support up to 8 work queues and work queues are classified
> > into
> > > dedicated queues and shared queues.
> > >
> > > A dedicated queue can only serve one process. Theoretically, there is no
> > limit
> > > on the number of processes in a shared queue, it is based on enqcmd +
> > SVM technology.
> > >
> > > https://www.kernel.org/doc/html/v5.17/x86/sva.html
> > 
> > This server has 200 CPUs which can thinkably migrate around 100 single
> > cpu qemu instances with no issue. What happens if you do this with DSA?
> 
> First, the DSA work queue needs to be configured in shared mode, and one
> queue is enough. 
> 
> The maximum depth of the work queue of the DSA hardware is 128, which means
> that the number of zero-page detection tasks submitted cannot exceed 128,
> otherwise, enqcmd will return an error until the work queue is available again
> 
> 100 Qemu instances need to be migrated concurrently, I don't have any data on
> this yet, I think the 100 zero-page detection tasks can be successfully submitted
> to the DSA hardware work queue, but the throughput of DSA's zero-page detection also
> needs to be considered. Once the DSA maximum throughput is reached, the work queue
> may be filled up quickly, this will cause some Qemu instances to be temporarily unable
> to submit new tasks to DSA.

The unfortunate reality here would be that there's likely no QoS, this
is purely fifo, right?

> This is likely to happen in the first round of migration
> memory iteration.

Try testing this and see then?


-- 
MST


