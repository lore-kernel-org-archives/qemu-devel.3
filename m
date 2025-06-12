Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF50C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 11:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPgLh-0000M1-GY; Thu, 12 Jun 2025 07:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPgLf-0000Ln-LZ
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 07:43:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uPgLd-0000ix-BT
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 07:43:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749728634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h5NVqZ1AknJetxQS+CjtMvyB44DYowTIdOJ0QBuAMVw=;
 b=Yk4enUuonTHHhK5Bb8Oxb9mjVmkpytY3mOP6QtIPLD0fPeXMR4hTr/zJ3APyv5+9+Fyqot
 ZF+DTVaSoS80R4+bIxUyGGGByaPmBFeIeVqMX5zCn0C5GocqEqlBaqCdMLMO0hdJMJJBU9
 WqvW+CP8ZkGOjRRuHeJ3aGW3l3r3Q/A=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-9-81rxmROZuaJTe6HxDr5w-1; Thu, 12 Jun 2025 07:43:53 -0400
X-MC-Unique: 9-81rxmROZuaJTe6HxDr5w-1
X-Mimecast-MFC-AGG-ID: 9-81rxmROZuaJTe6HxDr5w_1749728632
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7d0aa9cdecdso77674585a.3
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 04:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749728632; x=1750333432;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5NVqZ1AknJetxQS+CjtMvyB44DYowTIdOJ0QBuAMVw=;
 b=CxHkl+YHGNoBBxqIX2vRGHtSTWs3GqW7aoOdh1yUiv8R9SCBSf/qD0kNFDyyCn67E1
 xQA9ftq9x9W4XxCBWcrAhJlKPok+FJJyrRt77qAbTaQR+o3MKZLuMzV4dNBNh5bl41D1
 6+TJKcPxxAZUaigG39JGQ54cG4H0/hfeyHKaEfkzs1k3k5FlRVov1O9Js67OfWsrG9L/
 UuccJLfYLRSXiHEi/So0crd3Vrfbg7tJ7094oKo+hQmLQ5GDjvKM9AN9rjd1OGj0eszF
 syRnfiWNGtoOLO/k1fbExC6oCNqXBbGzwtW8Neu6AEWIxDo7QQUosC0CESMjhtiZmTW7
 aasg==
X-Gm-Message-State: AOJu0YwopBAbQJ48a4/GTHj3pf0ypomzUaiWxbDBB+r2/Ck1Rg5+Rssy
 rMpGvL2JYODH9UwGFsfq9Sb7J00dUZu/j83hsB+2n7odnHb28IeXW/Uq+Ra7kiVfDo9YjVVk0sz
 j42Tc1MoNqe+9Ss7Qduy3TRLDZiUe9NeepxifFLPaLJHTMCPdEQdzUuYA
X-Gm-Gg: ASbGnct30Cf1MieFc5mvb/+EFUdkmgFL8AI5Z6+scVZqJfx8HmJKeALQSzkLPoL8I2T
 tRrXPTyZM2Z81db+o6Ao8twdaSQ+Mhj1n+AmaRUbQ9GZ/j/IC4U6hAODJpwDur0IHBwqlXM8Ljc
 Vto3AprdL0N5Ls5qbsZ1D19pWZbAZC/BtZ3l9mcwfVaMz3HNSlE9EpLo1dzG7rRwpFdO73qMxEg
 f9AXbASyQoR++lWl/j8GPJvYCuapCMD9wGb/1mj7gIGeB84wCSYpbUh2fiuyaQDmSBqyM/AjZ80
 COykxzSjHkDvHw==
X-Received: by 2002:a05:620a:3198:b0:7d3:8ffa:f1bc with SMTP id
 af79cd13be357-7d3b36c9168mr407952385a.58.1749728632563; 
 Thu, 12 Jun 2025 04:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc6RGGWpxGydzqnjyIaEV+3egCFfCWcg3Fpa815mo0F2G3dm9hiIt5xSjhHaM+S+/WfdizoA==
X-Received: by 2002:a05:620a:3198:b0:7d3:8ffa:f1bc with SMTP id
 af79cd13be357-7d3b36c9168mr407949885a.58.1749728632214; 
 Thu, 12 Jun 2025 04:43:52 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb35c8b483sm9074736d6.118.2025.06.12.04.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jun 2025 04:43:51 -0700 (PDT)
Date: Thu, 12 Jun 2025 07:43:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Mario Casquero <mcasquer@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 00/11] migration: Some enhancements and cleanups for
 10.1
Message-ID: <aEq9dPYunkapeByP@x1.local>
References: <20250609161855.6603-1-peterx@redhat.com>
 <CAMXpfWtGPUDGtn40tkZYNMhntp48BbMRHnZqQkrBKokyMyEXyQ@mail.gmail.com>
 <aEl_RESZhLS56pv2@x1.local>
 <CAMXpfWuAkKoVJFvD_YFLzTpUZ_a-25jK_y1y-EA_Sk+LUC0B6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMXpfWuAkKoVJFvD_YFLzTpUZ_a-25jK_y1y-EA_Sk+LUC0B6A@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jun 12, 2025 at 12:35:46PM +0200, Mario Casquero wrote:
> Hello Peter,

Hi, Mario,

> 
> Thanks for pointing this out! I retested it with the series you
> mentioned and everything works fine.
> 
> Booted up 2 VMs as usual, one in source and one in destination with
> -incoming defer. Set the postcopy-blocktime and postcopy-ram
> capabilities and query them to verify that they are enabled.
> 
> (qemu) migrate_set_capability postcopy-ram on
> (qemu) migrate_set_capability postcopy-blocktime on
> (qemu) info migrate_capabilities
> 
> ...
> postcopy-ram: on
> ...
> postcopy-blocktime: on
> ...
> 
> Do migration with postcopy, this time check the full info migrate in source.
> (qemu) info migrate  -a
> Status: postcopy-active
> Time (ms): total=6522, setup=33, down=16
> RAM info:
>   Throughput (Mbps): 949.60
>   Sizes: pagesize=4 KiB, total=16 GiB
>   Transfers: transferred=703 MiB, remain=5.4 GiB
>     Channels: precopy=111 MiB, multifd=0 B, postcopy=592 MiB
>     Page Types: normal=178447, zero=508031
>   Page Rates (pps): transfer=167581
>   Others: dirty_syncs=2, postcopy_req=1652
> Globals:
>   store-global-state: on
>   only-migratable: off
>   send-configuration: on
>   send-section-footer: on
>   send-switchover-start: on
>   clear-bitmap-shift: 18
> 
> Once migration is completed compare the differences in destination
> about the postcopy blocktime.
> 
> (qemu) info migrate -a
> Status: completed
> Globals:
> ...
> Postcopy Blocktime (ms): 712
> Postcopy vCPU Blocktime (ms):
>  [1633, 1635, 1710, 2097, 2595, 1993, 1958, 1214]
> 
> With all the series applied and same VM:
> 
> (qemu) info migrate -a
> Status: completed
> Globals:
> ...
> Postcopy Blocktime (ms): 134
> Postcopy vCPU Blocktime (ms):
>  [1310, 1064, 1112, 1400, 1334, 756, 1216, 1420]
> Postcopy Latency (us): 16075

Here the latency is 16ms, my fault here - I forgot to let you enable
postcopy-preempt as well, sorry.

The optimization won't help much without preempt, because the optimization
is in tens of microseconds level.  So logically the optimization might be
buried in the noise if without preempt mode.  It's suggested to enable
preempt mode always for a postcopy migration whenever available.

> Postcopy non-vCPU Latencies (us): 14743
> Postcopy vCPU Latencies (us):
>  [24730, 25350, 27125, 25930, 23825, 29110, 22960, 26304]
> 
> Indeed the Postcopy Blocktime has been reduced a lot :)

I haven't compared with blocktime before, I'm surprised it changed that
much.  Though maybe you didn't really run any workload inside?  In that
case the results can be unpredictable.  The perf test would make more sense
if you run some loads so the majority of the faults triggered will not be
adhoc system probes but more predictable.  I normally use mig_mon [1] with
something like this:

[1] https://github.com/xzpeter/mig_mon

$ ./mig_mon mm_dirty -m 13G -p random

This first write pre-fault the whole memory using all the CPUs, then
dirties the 13G memory single threaded as fast as possible in random
fashion.

What I did with the test was applying both series then revert the last
patch of 1st series, as "postcopy-latency' metrics wasn't around before
applying the 2nd series, or you'll need to use some kernel tracepoints.

This is definitely an awkward series to test when having the two mangled.
Again, feel free to skip that, just FYI!

Thanks,

-- 
Peter Xu


