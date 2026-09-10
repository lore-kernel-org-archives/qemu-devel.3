Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEAC8C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 19:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4kXs-0004c4-Ap; Thu, 10 Sep 2026 15:34:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kRI-0002TK-91
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:28:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4kQq-0004g3-F6
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 15:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789068393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DKAz6UqAcJleKvQ2uMzzdF98Tku3YtvZfIgPsP4zirQ=;
 b=HOAoOuQtI/47uwGWBxtV9BycoVvjqBqJGOIFE3T4+6XM6+VNVk6WTpN6oTNJ1xdRp0Q7o8
 ZN02IrWPbOOQYLsYp8BZfEI8NBkJRTrGJB/o4gPOTtbP8YEhQi2Y9x0fAPKccTHjoKuZL9
 4s0h9uF8OFtVODyNOOjKk1p8oPTuZUo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-288-ISl5VEnTMcO-0Zjh2VWO6A-1; Thu, 10 Sep 2026 15:26:31 -0400
X-MC-Unique: ISl5VEnTMcO-0Zjh2VWO6A-1
X-Mimecast-MFC-AGG-ID: ISl5VEnTMcO-0Zjh2VWO6A_1789068391
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-78bb7517525so2080137.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 12:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789068391; x=1789673191; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DKAz6UqAcJleKvQ2uMzzdF98Tku3YtvZfIgPsP4zirQ=;
 b=H4SM/2kw+Y7QYY5lE0kdGGx1OB6Wv5A4WEA6zy30NgiypDFdE0pH62Spn2w0CTqWgD
 RZ65DYgpHvY58tYq2ATaJeRBaIEDGFP+c6qHb4WRO6j1symjgZbM60iQTfuWoI4fa9my
 IMu/tSwm6fxmXaYRnV9MRSd9HFyZUVEM/HAxkUtWlDb40TfJhEwJlPRA7GCfPRuF6Dzj
 ngRW0m2xTS5ZzfRP3RPgzE6N0cOY4gxQyq1MvNX4kWCNPlbE7ZX5n9jBQoiYBGsFDGCS
 ax5KDO2i/2vV819KqJtlfzzxfX0pu9w0vO6q9uqDUmAHXMxyo3G6GWp0NUQ6ftriTNE+
 JsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789068391; x=1789673191;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DKAz6UqAcJleKvQ2uMzzdF98Tku3YtvZfIgPsP4zirQ=;
 b=mcYmwLqTEEmkMQ1uCFGl5JLJeirqZv6Vbt+bBcbIRAt5RxRLrf3X3ECFMeyf6+jjZf
 2ubp4SgMNrltOxnib+YzLHt41mg/LhzKmpeyGXexHQhyCuRhsRWMxYkFgziDOfMo2pXU
 yYtt2GAogj6cKSiPdNClBBbIL5GFls73lQu8fAN/UY7MSHkK9bjCTC4X/YKgcICWihll
 lmrvV63HwA/XPjZIqlYkz5F/aPU9WfjB2ZCbkRiv5vLB46HtCH2LUk89qZZGTv1PU49q
 +5JETeE9j/zhwi/WfW1/p2cQFOBJm+/lL0hsEWvfIXLtMyMznm0AYy/NhbKjPUL1Mx4O
 3FIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7m3Y5OF/0tQhU8YJW3kx9lMqU3OpcE/HnJm3HzMpcf1Afddwj9l5TILbu5Fkmh8MDDpTXGmud5tMH@nongnu.org
X-Gm-Message-State: AFuF++mG8urmjSAf7Maq2o3cDLaU/htQOxIgVSaSUsRDdtge5zJalL+I
 +eewSg7GQrILN8+V/qkBfrB7oJr1f9/1IqlN3XiXF4ctJ8uCzFZTStvtPwJ+YDOkLy+SxG42na7
 sK2OhSfEcByxP35ymuVgmxaPQvqoFPXbEZ08H70SRqtY/IuCD3ucmOUbl
X-Gm-Gg: AYBFou1xAdmAbTH2NfG0Wu/OxO+oI+tg83ZGNLb6ujJkiA436UE4FxsuJ+iSA44iw3D
 oozuA0vMJs58Ovd/3ypsn/CuG3tSfg/cJKXSkj0XWKFRlXA6GCIroKzVm19jZ7hj7zleqU1OkiT
 lSOFUTKxPOHVEjcNYHhxmAJoLyztnXc/vXzGhx/CySZhmDc93ttHu/t697/Z4pUSczC2rQNmgjt
 0Dcy79gLr2RDGJoXFDiClZR0hv10G19236ySJd7TyTSIaVdeKPDNTXd8601hgYPVpIdVOteC2YG
 ZwGvL7LdwG8/l659VlH32sbMVgNwWn9obTCeEojrWyNq6bgZhJLnnp9100a+vWoxvjgQ
X-Received: by 2002:a05:6102:a87:b0:790:322:8a36 with SMTP id
 ada2fe7eead31-792a96a802bmr1315560137.8.1789068390798; 
 Thu, 10 Sep 2026 12:26:30 -0700 (PDT)
X-Received: by 2002:a05:6102:a87:b0:790:322:8a36 with SMTP id
 ada2fe7eead31-792a96a802bmr1315444137.8.1789068390068; 
 Thu, 10 Sep 2026 12:26:30 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4d51f4sm3060756d6.46.2026.09.10.12.26.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 12:26:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 15:26:18 -0400
From: Peter Xu <peterx@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 farosas@suse.de, eblake@redhat.com, maciej.szmigiero@oracle.com,
 mark.kanda@oracle.com, bchaney@akamai.com,
 pierrick.bouvier@oss.qualcomm.com, joe.jin@oracle.com
Subject: Re: [PATCH 1/5] migration/qapi: Add memfd migration transport
Message-ID: <aqMEWjTE9svymS8L@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260812232842.470225-1-dongli.zhang@oracle.com>
 <20260812232842.470225-2-dongli.zhang@oracle.com>
 <87a4qh46ao.fsf@pond.sub.org>
 <614160f2-2f3e-4489-ac4b-758f162be553@oracle.com>
 <87a4qg0wv9.fsf@pond.sub.org>
 <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a23d9e5b-d0ed-4e9d-95ae-e0fda4bb0453@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Aug 21, 2026 at 01:11:23PM -0700, Dongli Zhang wrote:
> So far I only added support for cpr-exec. I have not tried othe modes.
> 
> In my opinion, cpr-transfer could also use a memfd-backed channel, but I am not
> sure it is necessary.
> 
> For cpr-transfer, the source and destination are separate QEMU processes. If we
> want to pass a memfd between them, we still need an IPC mechanism that can
> transfer file descriptors, such as a Unix domain socket with SCM_RIGHTS. That
> reduces the value of using memfd as the migration channel, because we need at
> least one Unix domain socket anyway to pass the memfd fd and coordinate the handoff.
> 
> If a Unix domain socket is already required, the main benefit of memfd would
> likely be performance, especially when the device state is large.

I'm actually not sure dumping everything into one fd, then share it via the
other unix socket will be faster: the destination side can already start
parsing concurrently while reading things out, rather than waiting for
everything to land the page cache inside the memfd.

So I actually don't know if this will ever be useful by anything except
cpr-exec.

> 
> cpr-exec is different. The new QEMU is started via exec(), so the memfd fd can
> be preserved across exec by clearing CLOEXEC and passing the fd number through
> an environment variable. This allows us to add a memfd-backed migration channel
> without needing an external file or socket for the device state.
> 
> One potential future use case is LUO/KHO support for QEMU. In that case, device
> state could be preserved in memory as a memfd and potentially survive across a
> KHO kexec. We won't need to preserve anything on storage. Indeed, I did some
> internal tests using memfd to preserve device state across kexec although using
> different implementation, and it worked.

IIUC we can already do it: migrate file:/dev/shm/something, then make that
file handle persistent.

Then the question is, can we stick with that too for your feature?  Instead
of introducing the "memfd:" type, just use file?  Note that non-huge memfd
should literally be shmem at least on Linux.

Thanks,

-- 
Peter Xu


