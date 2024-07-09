Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61450C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 18:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRFny-0004yd-6O; Tue, 09 Jul 2024 14:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRFnw-0004y2-GB
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sRFnu-0000AO-18
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 14:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720550583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h32t5Qeewct+xkpZMKgyT8AtUh95jHno78TnKkUZLSw=;
 b=ehW07sMXPxXWk1wLbvLoV/wYpjpWt9Msd3gDuhG1sD8Ihe/XhT8SDEPOgQAFUGCHuu30AB
 ofAnIJzVeQ0WSRmEkPecK8VyANtDNpbMtBBHdoFxCHC18PIwHXbYkcvrlvX+PaGRmN37HE
 GD4z/1UoqdNqWtQPHzN+Ne3DGWCizIs=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-iGmd-U8JPWCo9BPyBajYSw-1; Tue, 09 Jul 2024 14:43:01 -0400
X-MC-Unique: iGmd-U8JPWCo9BPyBajYSw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-447dfad3387so10350141cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2024 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720550580; x=1721155380;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h32t5Qeewct+xkpZMKgyT8AtUh95jHno78TnKkUZLSw=;
 b=FG/waSC/5o+mIKaMPtg6DA2YM8g/u+YGLUGA8tql3nkx5om5oZ0G+2/LC9yjXASWQa
 4gp0D9Q1p5EpauHAP3r5TiH26ecok7iGLMjnmfBI24k6442fkSkZOl8zdKMJUUWo5y6L
 mqmfByyY6yRjTUdUQyjr0sH2jOt7zfxN3ag88doWjGfPY0ruJERxhheVZBPRqWXsj+ot
 h3yWQb+fI4E1Yon3ayhcmSVVdINRiFvJ3HZ1XbmvAJWUHhdSHg9jYVvYUzYOwWWRuSEJ
 eyP8FoHMj7s2RdByZlKxedTMz8MDAm1iCHkmmKrTHS8hQroly+NK35Jojo6Rute2MmY1
 mlkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuxtiyY39vq0rbhdJYSqwbLRTVAdmCcuwA/QMiwmEEUDagWWRV+GmPSY3ZXljvlWLUvZKmlfiTF8TUTA+umxnomaFF7PY=
X-Gm-Message-State: AOJu0YyvWx4fa8b35Eo4HivCJw5kxw7Xe3oHRAvIcw5O+ZM5oM9RHpfs
 oTsvLvDkikhv1+J018ik3t4I+s8jgMTcJ9poIgGMYRKPxjQoF6++bwQr6ycBLm4N5ckTSuaJq0D
 oAOerkAomqZYYkLf0YhLXuotNSA2/BJ2XHZHftLPNUyQaArG9ewHS
X-Received: by 2002:a05:622a:253:b0:441:37b:cd7a with SMTP id
 d75a77b69052e-447faa36adcmr38102731cf.3.1720550580474; 
 Tue, 09 Jul 2024 11:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHd+Oi0ea0lLdibD5p3uV9x1DmP2vgXOyZUfeKD0gUXMvwbJIA9s9KGLV/mGKMPrL02c5E1Zg==
X-Received: by 2002:a05:622a:253:b0:441:37b:cd7a with SMTP id
 d75a77b69052e-447faa36adcmr38102461cf.3.1720550579982; 
 Tue, 09 Jul 2024 11:42:59 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-447f9bf6729sm12863691cf.94.2024.07.09.11.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 11:42:59 -0700 (PDT)
Date: Tue, 9 Jul 2024 14:42:56 -0400
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yuan1" <yuan1.liu@intel.com>
Cc: "Wang, Yichen" <yichen.wang@bytedance.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Subject: Re: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
Message-ID: <Zo2EsEqAY5KnkO1V@x1n>
References: <20240705182901.48948-1-yichen.wang@bytedance.com>
 <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB5941B008DD622227FB46E95EA3DB2@PH7PR11MB5941.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

On Tue, Jul 09, 2024 at 08:42:59AM +0000, Liu, Yuan1 wrote:
> > -----Original Message-----
> > From: Yichen Wang <yichen.wang@bytedance.com>
> > Sent: Saturday, July 6, 2024 2:29 AM
> > To: Paolo Bonzini <pbonzini@redhat.com>; Daniel P. Berrangé
> > <berrange@redhat.com>; Eduardo Habkost <eduardo@habkost.net>; Marc-André
> > Lureau <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>;
> > Philippe Mathieu-Daudé <philmd@linaro.org>; Peter Xu <peterx@redhat.com>;
> > Fabiano Rosas <farosas@suse.de>; Eric Blake <eblake@redhat.com>; Markus
> > Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu-
> > devel@nongnu.org
> > Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> > Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> > <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>
> > Subject: [PATCH v4 0/4] Implement using Intel QAT to offload ZLIB
> > 
> > v4:
> > - Rebase changes on top of 1a2d52c7fcaeaaf4f2fe8d4d5183dccaeab67768
> > - Move the IOV initialization to qatzip implementation
> > - Only use qatzip to compress normal pages
> > 
> > v3:
> > - Rebase changes on top of master
> > - Merge two patches per Fabiano Rosas's comment
> > - Add versions into comments and documentations
> > 
> > v2:
> > - Rebase changes on top of recent multifd code changes.
> > - Use QATzip API 'qzMalloc' and 'qzFree' to allocate QAT buffers.
> > - Remove parameter tuning and use QATzip's defaults for better
> >   performance.
> > - Add parameter to enable QAT software fallback.
> > 
> > v1:
> > https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg03761.html
> > 
> > * Performance
> > 
> > We present updated performance results. For circumstantial reasons, v1
> > presented performance on a low-bandwidth (1Gbps) network.
> > 
> > Here, we present updated results with a similar setup as before but with
> > two main differences:
> > 
> > 1. Our machines have a ~50Gbps connection, tested using 'iperf3'.
> > 2. We had a bug in our memory allocation causing us to only use ~1/2 of
> > the VM's RAM. Now we properly allocate and fill nearly all of the VM's
> > RAM.
> > 
> > Thus, the test setup is as follows:
> > 
> > We perform multifd live migration over TCP using a VM with 64GB memory.
> > We prepare the machine's memory by powering it on, allocating a large
> > amount of memory (60GB) as a single buffer, and filling the buffer with
> > the repeated contents of the Silesia corpus[0]. This is in lieu of a more
> > realistic memory snapshot, which proved troublesome to acquire.
> > 
> > We analyze CPU usage by averaging the output of 'top' every second
> > during migration. This is admittedly imprecise, but we feel that it
> > accurately portrays the different degrees of CPU usage of varying
> > compression methods.
> > 
> > We present the latency, throughput, and CPU usage results for all of the
> > compression methods, with varying numbers of multifd threads (4, 8, and
> > 16).
> > 
> > [0] The Silesia corpus can be accessed here:
> > https://sun.aei.polsl.pl//~sdeor/index.php?page=silesia
> > 
> > ** Results
> > 
> > 4 multifd threads:
> > 
> >     |---------------|---------------|----------------|---------|---------|
> >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
> >     |---------------|---------------|----------------|---------|---------|
> >     |qatzip         | 23.13         | 8749.94        |117.50   |186.49   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zlib           |254.35         |  771.87        |388.20   |144.40   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zstd           | 54.52         | 3442.59        |414.59   |149.77   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |none           | 12.45         |43739.60        |159.71   |204.96   |
> >     |---------------|---------------|----------------|---------|---------|
> > 
> > 8 multifd threads:
> > 
> >     |---------------|---------------|----------------|---------|---------|
> >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
> >     |---------------|---------------|----------------|---------|---------|
> >     |qatzip         | 16.91         |12306.52        |186.37   |391.84   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zlib           |130.11         | 1508.89        |753.86   |289.35   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zstd           | 27.57         | 6823.23        |786.83   |303.80   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |none           | 11.82         |46072.63        |163.74   |238.56   |
> >     |---------------|---------------|----------------|---------|---------|
> > 
> > 16 multifd threads:
> > 
> >     |---------------|---------------|----------------|---------|---------|
> >     |method         |time(sec)      |throughput(mbps)|send cpu%|recv cpu%|
> >     |---------------|---------------|----------------|---------|---------|
> >     |qatzip         |18.64          |11044.52        | 573.61  |437.65   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zlib           |66.43          | 2955.79        |1469.68  |567.47   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |zstd           |14.17          |13290.66        |1504.08  |615.33   |
> >     |---------------|---------------|----------------|---------|---------|
> >     |none           |16.82          |32363.26        | 180.74  |217.17   |
> >     |---------------|---------------|----------------|---------|---------|
> > 
> > ** Observations
> > 
> > - In general, not using compression outperforms using compression in a
> >   non-network-bound environment.
> > - 'qatzip' outperforms other compression workers with 4 and 8 workers,
> >   achieving a ~91% latency reduction over 'zlib' with 4 workers, and a
> > ~58% latency reduction over 'zstd' with 4 workers.
> > - 'qatzip' maintains comparable performance with 'zstd' at 16 workers,
> >   showing a ~32% increase in latency. This performance difference
> > becomes more noticeable with more workers, as CPU compression is highly
> > parallelizable.
> > - 'qatzip' compression uses considerably less CPU than other compression
> >   methods. At 8 workers, 'qatzip' demonstrates a ~75% reduction in
> > compression CPU usage compared to 'zstd' and 'zlib'.
> > - 'qatzip' decompression CPU usage is less impressive, and is even
> >   slightly worse than 'zstd' and 'zlib' CPU usage at 4 and 16 workers.
> 
> Hi Peter & Yichen
> 
> I have a test based on the V4 patch set
> VM configuration:16 vCPU, 64G memory, 
> VM Workload: all vCPUs are idle and 54G memory is filled with Silesia data.
> QAT Devices: 4
> 
> Sender migration parameters
> migrate_set_capability multifd on
> migrate_set_parameter multifd-channels 2/4/8
> migrate_set_parameter max-bandwidth 1G/10G

Ah, I think this means GBps... not Gbps, then.

> migrate_set_parameter multifd-compression qatzip/zstd
> 
> Receiver migration parameters
> migrate_set_capability multifd on
> migrate_set_parameter multifd-channels 2
> migrate_set_parameter multifd-compression qatzip/zstd
> 
> max-bandwidth: 1GBps
>      |-----------|--------|---------|----------|------|------|
>      |2 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   21607|       77|      8051|    88|   125|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   78351|       96|      2199|   204|    80|
>      |-----------|--------|---------|----------|------|------|
> 
>      |-----------|--------|---------|----------|------|------|
>      |4 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   20336|       25|      8557|   110|   190|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   39324|       31|      4389|   406|   160|
>      |-----------|--------|---------|----------|------|------|
> 
>      |-----------|--------|---------|----------|------|------|
>      |8 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   20208|       22|      8613|   125|   300|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   20515|       22|      8438|   800|   340|
>      |-----------|--------|---------|----------|------|------|
> 
> max-bandwidth: 10GBps
>      |-----------|--------|---------|----------|------|------|
>      |2 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   22450|       77|      7748|    80|   125|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   78339|       76|      2199|   204|    80|
>      |-----------|--------|---------|----------|------|------|
> 
>      |-----------|--------|---------|----------|------|------|
>      |4 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   13017|       24|     13401|   180|   285|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   39466|       21|      4373|   406|   160|
>      |-----------|--------|---------|----------|------|------|
> 
>      |-----------|--------|---------|----------|------|------|
>      |8 Channels |Total   |down     |throughput| send | recv |
>      |           |time(ms)|time(ms) |(mbps)    | cpu %| cpu% |
>      |-----------|--------|---------|----------|------|------|
>      |qatzip     |   10255|       22|     17037|   280|   590|
>      |-----------|--------|---------|----------|------|------|
>      |zstd       |   20126|       77|      8595|   810|   340|
>      |-----------|--------|---------|----------|------|------|

PS: this 77ms downtime smells like it hits some spikes during save/load.
Doesn't look like reproducable comparing to the rest data.

> 
> If the user has enabled compression in live migration, using QAT
> can save the host CPU resources.
> 
> When compression is enabled, the bottleneck of migration is usually
> the compression throughput on the sender side, since CPU decompression
> throughput is higher than compression, some reference data 
> https://github.com/inikep/lzbench, so more CPU resources need to be 
> allocated to the sender side.

Thank you, Yuan.

> 
> Summary:
> 1. In the 1GBps case, QAT only uses 88% CPU utilization to reach 1GBps, 
>    but ZSTD needs 800%.
> 2. In the 10Gbps case, QAT uses 180% CPU utilization to reach 10GBps
>    But ZSTD still cannot reach 10Gbps even if it uses 810%.

So I assumed you always meant GBps across all the test results, as only
that matches with max-bandwidth parameter.

Then in this case 10GBps is actually 80Gbps, which was not a low bandwidth
test.

And I think the most interesting one that I would be curious is nocomp in
low network tests.  Would you mind run one more test with the same
workload, but with: no-comp, 8 channels, 10Gbps (or 1GBps)?

I think in this case multifd shouldn't matter a huge deal, but let's still
enable that just assume that's the baseline / default setup.  I would
expect this result should obviously show a win on using compressors, but
just to check.

> 3. The QAT decompression CPU utilization is higher than compression and ZSTD,
>    from my analysis
>    3.1 when using QAT compression, the data needs to be copied to the QAT 
>        memory (for DMA operations), and the same for decompression. However, 
>        do_user_addr_fault will be triggered during decompression because the 
>        QAT decompressed data is copied to the VM address space for the first time,
>        in addition, both compression and decompression are processed by QAT and 
>        do not consume CPU resources, so the CPU utilization of the receiver is 
>        slightly higher than the sender.

I thought you hit this same issue when working on QPL and I remember you
used -mem-prealloc.  Why not use it here?

>    
>    3.2 Since zstd decompression decompresses data directly into the VM address space, 
>        there is one less memory copy than QAT, so the CPU utilization on the receiver
>        is better than QAT. For the 1GBps case, the receiver CPU utilization is 125%,
>        and the memory copy occupies ~80% of CPU utilization.

Hmm, yes I read that part in code and I thought it was a design decision to
do the copy, the comment said "it is faster".  So it's not?

I think we can definitely submit compression tasks per-page rather than
buffering, if that would be better.

> 
>    I think this is acceptable. Considering the overall CPU usage of the sender and receiver, 
>    the QAT benefit is good.

Yes, I don't think there's any major issue to block this from supported,
it's more about when we are at it we'd better figure all things out.

For example, I think we used to discuss the use case where there's 100G*2
network deployed, but the admin may still want to have some control plane
VMs moving around using very limited network for QoS.  In that case, I
wonder any of you thought about using postcopy?  I assume the control plane
workload isn't super critical in this case or it won't get provisioned with
low network for migrations, in that case maybe it'll also be fine to
post-copy after one round of precopy on the slow-bandwidth network.

Again, I don't think the answer blocks such feature in any form whoever
simply wants to use a compressor, just to ask.

Thanks,

-- 
Peter Xu


