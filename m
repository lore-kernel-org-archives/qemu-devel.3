Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC4CCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWx2Z-0003O4-0Z; Tue, 09 Jun 2026 10:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWx2B-0003DM-IP
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWx29-0005Sr-PQ
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:02:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781013743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ljpn1/B0V7Hz3sE+FyD+JHRLoi83cYoioZk/6VTfguE=;
 b=AovWtipjtVV46q5U4YwNPcGFoYGckL/dRmzVfAeuZi+jFPStIdO+UX0XG2+oTEybHd2jMd
 RjlWZXOZ5s0T/n4IiFY74gp8ootQUaBX2orf787ya7o22vCZ1xVpbZAQOzFwMIZBEFu3Su
 zwaRxxnnPC5LY0wRToGJp2nf3hIPv+Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-KdFPvQfiMaCA518oeLnyfg-1; Tue, 09 Jun 2026 10:02:22 -0400
X-MC-Unique: KdFPvQfiMaCA518oeLnyfg-1
X-Mimecast-MFC-AGG-ID: KdFPvQfiMaCA518oeLnyfg_1781013741
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-490b8adf8b8so51159505e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781013741; x=1781618541; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ljpn1/B0V7Hz3sE+FyD+JHRLoi83cYoioZk/6VTfguE=;
 b=nXyFexNKy84QviXBq1vOhuPoiZvZmJyrXGwdNzGCgvDXTEL9ilSaRh0tWdmwGkYVeZ
 0DO6PMLppvhon5xgLjA4OVeM8Z0xWh9zDKB0CRKdwwY3vQHRuBxDskUh7H73OZ08xnIs
 IqFg6u4f2C39M4yjZ16thOsjGrcs98vQ3CtzocZy4M9gnlgEa2HN8OE6JnPsLs+l1ILW
 iRWOE9w4VI2fUuw1xx/VXBd5rsjqkouLY+m9cvBp97SAQk4BdJ3Kyw2LGBnPh2cn6cYt
 fK/6SH4bma7jI9fAI3Rl9LK8HFJkkkqoCsBtU/yp/BRLn3cOtCaD0NTACherpqQcmqJW
 P8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781013741; x=1781618541;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ljpn1/B0V7Hz3sE+FyD+JHRLoi83cYoioZk/6VTfguE=;
 b=Pzcyv0niv7Q7+ucPuy50U5TUdLdmxII+Ab3FD/puxBWqHIAQffiC+/9RXbKM75Cibt
 vSaFuHLpduwC8dPCOW8WQXjb62OxA3+lFJZPL2mz6Rrlkeb/+VTDyhBu5rwwTInxd247
 ivLQ6nIRYDQDCHeDZ3tmmTipATUST3+BDpWJw7NhDrlEneuDC2KX9U0YBFEyN7HGG6sK
 6MXfaNbGTxNQrvNgQkh++oQ3maqplQ90GW1X3URt7n3L9J5ET5noKsXjdcqtI/cjzOXF
 4Dhv9rTJtXG0VDGjuzi8quaptM0G6nVH43MtG5+grS452ptXyu3vRu8Croifr/M53WH9
 +0Dg==
X-Gm-Message-State: AOJu0YzkjdKp21J16ry+rc6+aWA0vdPW75P3q0BswEOqmegYeEbPTbft
 2KdIpzBFQN0hfHevUpCA7LERdNZFRyisE1WW4CFW3sLSqgchbzd/69ZWCuPE1T/3PDuKFZKls1u
 nVjDnnY3u1aM7TCmLSNCuHdd4tXEIPH5p69Tvjav9XbEp+DKmpZwq5XJs
X-Gm-Gg: Acq92OGEGEzNp1NtYn011NTLYMg87BtGdCc/cSU5zvtAQfOJEpUG3phtNK22MxPzJME
 YgmQAml9eAm4+1j2JSxS1T1JTDV/WvG1u5+DRf/WzIXbNG9IwA1+lZ6vH8bBgZOj6X6yClLvuVy
 9qdRKmb+naYmgIhnF2f9d8iJCWtzYw6vqj4tbty5Y9LW/Oa8EAJAlsn5VysyjZ95Tl5JD/AiS5O
 ahCNk816dKM1238nsNj+w/8E9onpYj/nK6TKmVxz/5FdFzFzmdw2EzK3agX1Gy/5d7/hZVU1RGy
 vzTdf4vqD1df8rYO+a/oWTnel+/pBtKVrsM299UawuvpMz7De6qC/sL1Xo+zV8meehj94/JaoTH
 KW38ZErO2e3GuFqVLwp5bnDAFj+rAUXf5HhYjp5+bK0W6jg3LoZHqYvIGxAUHRLTerNTAyA==
X-Received: by 2002:a05:600c:4e94:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-490c25e30e0mr342363365e9.18.1781013740875; 
 Tue, 09 Jun 2026 07:02:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e94:b0:490:9588:bdae with SMTP id
 5b1f17b1804b1-490c25e30e0mr342362775e9.18.1781013740330; 
 Tue, 09 Jun 2026 07:02:20 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e59f5sm512624415e9.14.2026.06.09.07.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 07:02:19 -0700 (PDT)
Date: Tue, 9 Jun 2026 16:02:17 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] igvm: populate errp in stub functions
Message-ID: <aigUdNYq0YRtAZKt@leonardi-redhat>
References: <20260609-igvm_stubs-v1-1-5f39d6e0db4a@redhat.com>
 <aigULaw73khPNxoR@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aigULaw73khPNxoR@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hi Daniel,

On Tue, Jun 09, 2026 at 02:25:01PM +0100, Daniel P. Berrangé wrote:
>On Tue, Jun 09, 2026 at 03:20:14PM +0200, Luigi Leonardi wrote:
>> Use error_setg() to report that IGVM is not available, matching
>> the pattern used by other stubs in the tree.
>>
>> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
>> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> ---
>>  stubs/igvm.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/stubs/igvm.c b/stubs/igvm.c
>> index 9e9f683fc9..dfb85eb548 100644
>> --- a/stubs/igvm.c
>> +++ b/stubs/igvm.c
>> @@ -17,15 +17,18 @@ int qigvm_x86_get_mem_map_entry(int index,
>>                                  ConfidentialGuestMemoryMapEntry *entry,
>>                                  Error **errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>>
>>  int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>>
>>  int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
>>  {
>> +    error_setg(errp, "IGVM not supported on this platform");
>>      return -1;
>>  }
>
>This is not wrong per-se, so on that  basis
>
>  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>
>but are any of these stubs actually reachable when IGVM is not
>enabled in the build ? Usually with stubs we find that one
>or two methods are the primary entrypoints which must return
>an error, at which point everything else becomes unreachable.
>The latter cases can just be g_assert_not_reached() as a sanity
>check that some unexpected codepath isn't calling in without
>checking status earlier. Those would thus would not need
>error_setg, nor a 'return' statement.

No, when IGVM is not enabled in the build it's not possible to trigger
any of these stubs. On top of that, I don't think it is possible to trigger
these stubs even when igvm is enabled. This is because the only architecture
that implements igvm support in qemu is x86.

To give more context: the igvm code is split between `backends/igvm.c` and
`target/i386/igvm.c`. The former contains arch-independent functions,
while the latter, x86 related functions.

Therefore, stubs will only become relevant when new architectures will be
supported.

I'm not sure about using asserts here, because with this patch [1] we'll
handle optional igvm directives. So, when we support aarch64 in igvm,
we could have some directives (eg: `IGVM_VHT_MADT`) that are
implemented for one architecture but not for a different one, resulting
in the stub being hit. So, if that directive is marked as optional in the
igvm file, we should not crash qemu.

[1] https://lore.kernel.org/all/20260609-igvm_optional-v2-2-b1f1f08dc40e@redhat.com/

HTH,
Luigi


