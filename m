Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45C90E77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 16:50:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVZG4-0006tB-Bt; Wed, 08 Jan 2025 11:50:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVZG1-0006rc-Kp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tVZFy-0004PH-Um
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 11:50:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736355008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AsrxZeFSrujJ4GnUoZjyAlRG/4C+zcSRw7wGojTzmnc=;
 b=X5zvQIJR+r2/nAyJFNU3Iby8g02mRVRESoLshqeGMSphmcC3Vs/OZg8QUfxbbzguPhshyK
 INkVKHOYm5bBOB/CJrZhnm1pYHyiMchdVZh87cS+ZI6uRSa55pyN4Y/NzvbSK4o8Mw2rV1
 t+NogDnhPn8Zn5jBzdW0pVAKzB1Njwg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-scco57g1POiQM9M53_ynEQ-1; Wed, 08 Jan 2025 11:50:07 -0500
X-MC-Unique: scco57g1POiQM9M53_ynEQ-1
X-Mimecast-MFC-AGG-ID: scco57g1POiQM9M53_ynEQ
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7b6e241d34eso2398959785a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2025 08:50:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736355007; x=1736959807;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsrxZeFSrujJ4GnUoZjyAlRG/4C+zcSRw7wGojTzmnc=;
 b=W/HAere2gUt2/W24fNZCHgScRcDkQx9fKiNg8pDz/3sgHJNTU/n7SccINFPHlpyZFB
 YDVklzw9wh5FFpYnweZVRr5CS8aPzYmJwpZrXmup6PrAO89AYsW+TPyd1mpUqdKss5fL
 gUSuuabCsyOHcQCsFXKL7dcRTZbrKkzKhAqZw3IuP4gbA8/c5nP3a5iyMFyN7gyinJKa
 etZNmhLoT4+DCeODAcqR1YET6Gk0PPLkRSFdcn422mdti+7tcnQytWryIQpMBPUSOhgF
 MrDoRrrlG6RWgtRzItTU8P0z4aIlKwAbrR5cAPu04m7BVfHmOPgy8XRL0N1DR7YXs3Vu
 lGTA==
X-Gm-Message-State: AOJu0YxQ2ZSlsWPe7usMgxaC+0T1BbfEhmvtHy6DU425pPzlh1ukAIOu
 OTu23K4kflvWEw+jCoG4qRfIqusb5hf5v2UDqgJnOK/VHa1JcwdEwlufd294jFK5gtdsTITUmgj
 vKckm1A8NQKjEPEVwZTVhi5OtDm1/aqAdaXERA5W5AoE6rxTLHRb/
X-Gm-Gg: ASbGncsX4QnbBoJ4hcXuTLHd86NFE72Y7FciIppjpmc/Cz2o431rEY/4DhdO5jcXzOB
 sCTZFgd8eWBeB5Tu8s5nfYIVl06wMJjP6uuCxfoYt1k/qYI4DrZqhqBwB0nbEhsDQCBna2v/gEY
 ekMKwGN0G+kHnuWmNOxNbJ1hinfx1rrXQmv2juKXqWuY8ijd/G0iaOupn/m33+OusTmC3Vrm1S1
 dalezCs10bAsXBzCLBPzMlzhvWcrb5TrLyMep39XBE+cGCgsL5cJ58+FHt/44wwElNlFDEnUIKM
 xzDCIJ6R7Aw/Vp31EA==
X-Received: by 2002:a05:620a:2682:b0:7b6:d050:720f with SMTP id
 af79cd13be357-7bcd974a173mr495513785a.22.1736355007006; 
 Wed, 08 Jan 2025 08:50:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6FNs+3fNfm9rVtmY1EVDtHq3TmBxewLKGpfjXRbbdkIdAnXg4VVZmCZmwMg0XNTos/P/9+Q==
X-Received: by 2002:a05:620a:2682:b0:7b6:d050:720f with SMTP id
 af79cd13be357-7bcd974a173mr495510885a.22.1736355006647; 
 Wed, 08 Jan 2025 08:50:06 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac47a6cdsm1679489585a.93.2025.01.08.08.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2025 08:50:06 -0800 (PST)
Date: Wed, 8 Jan 2025 11:50:03 -0500
From: Peter Xu <peterx@redhat.com>
To: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [RFC PATCH 2/5] system/memory: support unaligned access
Message-ID: <Z36su8G_hlkdBFy6@x1n>
References: <20241108032952.56692-1-tomoyuki.hirose@igel.co.jp>
 <20241108032952.56692-3-tomoyuki.hirose@igel.co.jp>
 <Z04lW_CdYBPJRah3@x1n>
 <2de74447-00f7-4bcf-81f3-c8461ec19a67@igel.co.jp>
 <Z1MpY7ZIAAoBDbZU@x1n>
 <9d1f07e5-2c08-455c-a653-e57e219666ab@igel.co.jp>
 <Z1oYIn5cMZeA4tes@x1n>
 <1ab0a747-e2c4-4545-bae9-31e19c77bd75@igel.co.jp>
 <Z1sFUxCiQp3Nziu_@x1n>
 <2e2dba3c-2bfc-478a-988d-fbf2e58cc293@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2e2dba3c-2bfc-478a-988d-fbf2e58cc293@igel.co.jp>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Hi, Tomoyuki,

On Wed, Jan 08, 2025 at 11:58:10AM +0900, Tomoyuki HIROSE wrote:
> Happy new year, Peter.
> I had another job and was late in replying to your email, sorry.

Happy new year.  That's fine. :)

[...]

> > So.. it turns out we shouldn't drop impl.unaligned?  Because above two
> > seems to be the real user of such.  What we may want to do is:
> > 
> >    - Change above two use cases, adding impl.unaligned=true.
> > 
> >      This step should hopefully have zero effect in reality on the two
> >      devices.  One thing to mention is both of them do not look like to have
> >      an upper bound of max_access_size (either 8 which is the maximum, or
> >      not specified).
> 
> This might be a good way. In this way, we need to add 'impl.unaligned
> = true' to the xHCI Capability Register's MR. We also need to fix the

We need to keep xHCI's impl.unaligned to FALSE?  IIUC only if it's FALSE
would it start to use your new code in this series to automatically convert
the unaligned access request into one or multiple aligned accesses (without
changing xHCI's MR ops implementation, IOW resolve this in memory core).

I just had another look at your last patch:

https://lore.kernel.org/qemu-devel/20241108032952.56692-6-tomoyuki.hirose@igel.co.jp/

index d85adaca0d..f35cbe526f 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3165,9 +3165,11 @@ static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = 8,
+    .valid.unaligned = true,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
+    .impl.unaligned = false,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };

I think that should keep being valid.  So "valid.unaligned = true" will
start enable unaligned accesses from the API level which will start to
follow the xHCI controller's spec, then ".impl.unaligned = false" tells the
memory core to _not_ pass unaligned accesses to MR ops, instead break them
down properly.

> MR implementation to be safe when unaligned accessing (current xHCI
> implementation does not handle unaligned accesses but the spec allows
> unaligned accesses).
> 
> In addition, maybe it would be better to document the constraint that
> the situation where 'valid.unaligned = true' and 'impl.unaligned =
> false' is not supported.

Do you perhaps mean this instead?

  valid.unaligned = FALSE && impl.unaligned == TRUE

If so, I agree.  I think we could even consider adding an assertion into
memory_region_init_io() to make sure it won't be set.

Thanks,

-- 
Peter Xu


