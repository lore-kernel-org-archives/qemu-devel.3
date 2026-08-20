Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C09D4C5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 18:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx7KO-00065s-OI; Thu, 20 Aug 2026 14:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx7KK-00065b-Ar
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wx7KH-0007LY-IQ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 14:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787249832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hn7V6U5mapGW5tqoe95SHLBj2raeRhPaMg7UNqyfXDU=;
 b=bVd7idfyAzKGnN2TjY8RkH6mzkuhoXThQg4uv8ou5tyKqyrQjjSFvH3WeuduvLGvoGhbAQ
 DVzdQsNMpeM//T64f2IAtLD365FEB9wiZsvpyElfxalUvSeZIlY6mSLoX97sgx+3NSQEjP
 2uy8CPxvnzXclwaxS7VCdHCUJjiIKTA=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-JKFBa1dRPE2kBR2VufLiRw-1; Thu, 20 Aug 2026 14:17:11 -0400
X-MC-Unique: JKFBa1dRPE2kBR2VufLiRw-1
X-Mimecast-MFC-AGG-ID: JKFBa1dRPE2kBR2VufLiRw_1787249830
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7e9e741693bso241070a34.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787249830; x=1787854630; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hn7V6U5mapGW5tqoe95SHLBj2raeRhPaMg7UNqyfXDU=;
 b=KyAYUlu8DuAGIMCr3nFIT33x9KGeY6/95Ri8pW4bXJKGA+2j3ZTqi3anr/7FhFuVd9
 xznOe2i6mNAJ1Jf0BLpBkTRP1D6p5lHxq0H2U9CWuHQjvW3nelz6uqZ3doqTODrqgzz3
 QAaUCkzNRcJeYRlWVQ4x8FAixUKF5rEhkEg5RyugIhLAgFQslY2gAJEA5kWj2CEd843u
 sxl7m1gnldbEHO0NWR20lFFmDhZa0I2rppZZSJKZLUzBr2CkIHDHWIEOoJq/ui4Eq9H5
 lKgWy+QhpMKnF79I6WStxrDVaNaEUtfAbauVFJ8veXy9xlv5HrW4uW3EIyUdlBLlGkee
 CoCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787249830; x=1787854630;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Hn7V6U5mapGW5tqoe95SHLBj2raeRhPaMg7UNqyfXDU=;
 b=T3f71SsVumgulYH2FgqbUZsHobhulVu0XlhTqz6dez72lj9DhYLLVzwO+spzB98GMt
 h1m3Ghrszy3h/aNSytPcW4HNNGOzoYQFEefnGwXak4I4gh/GmZdfb+JqiYIVGCjq9CdG
 0P13wH7/rXSN+b3nIJQJCfCCAi4ksS5RRcnOq/r0xYFY1n8XixnkcUZCKW9twRq6Niae
 aOUSBghVQg68IcgFBwakfIRRuZPrucmq4BOiEXwKKn0IW4q996RZedcalMSQICkIfkTe
 +pfr7ej+mSt9lEszZBfZkKfX/EJ0l6JzGGF3AeO/K3Wcv8Ca1q2pA0pRNIRVSS80g39S
 cGsQ==
X-Gm-Message-State: AOJu0YwZkWjV/vdJN5W0ZCQEO47EbAKH+rsVSU4wafdRg2Ybd8V34/yG
 02XS24KNNvhBqWNPMz1NeiArB+/3u7GORNrm5IMmlTePGKmCQ1Ow2W2s3FntYIvoLK7q9/Em9Dc
 mrFWPFQxqi+xGJgBskomx7nxh5MKvhMEPu3fxnrX8jNShuqcoNmuTjW0G
X-Gm-Gg: AR+sD1382k1hiNnrWNLjMrinuq7/7GmZJGQ3kvUVGnh8664jtqVyB6a7BOSGCtIxjFj
 hE3t7Vi6rusaT1MahM2GQuPobvb6CjRtSgLdgfwp0gM0QGgdCSxXs1l+51KLtv3VLIuYk+Md8F9
 msM54VTLEaLHqAwnOWVeB0WE7JUfXo5a0ufubsd0Ru9avs3YT0HJS7Uewl0ROiTcv3RjzkYx2Xq
 Rjaq+NbzxAZcFcaVshmZOs1NhoLfOlgmY7E80HPdpJkkq3R9mnXohE/6ivQS2ZTcdWz313h+QBS
 AlEp5NfiXHMX0u/jr8rBtBHw23EARndeOykuE8dkZOLsaYPngpeQtlvtHWMBehIKVvU8VSLHTp/
 +yfr2ZWci6485AwyIB41hSNG8pQ+eyqYT3AIzolvI/FRR6SsloyQqr6aY3uE=
X-Received: by 2002:a05:6830:6404:b0:7e6:d384:459e with SMTP id
 46e09a7af769-7f4613487b7mr451798a34.3.1787249830253; 
 Thu, 20 Aug 2026 11:17:10 -0700 (PDT)
X-Received: by 2002:a05:6830:6404:b0:7e6:d384:459e with SMTP id
 46e09a7af769-7f4613487b7mr451721a34.3.1787249829730; 
 Thu, 20 Aug 2026 11:17:09 -0700 (PDT)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f44005680bsm5770214a34.22.2026.08.20.11.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:17:06 -0700 (PDT)
Date: Thu, 20 Aug 2026 14:17:04 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v3 70/74] memory: use object_property_add_link for
 container property
Message-ID: <aodEoKLdc8q5hnQw@x1.local>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
 <20260818-qom-qapi-v3-70-24b8bbbe3d86@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818-qom-qapi-v3-70-24b8bbbe3d86@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Aug 18, 2026 at 05:29:36PM +0400, Marc-André Lureau wrote:
> Replace the hand-rolled container property with
> object_property_add_link().
> 
> With check=NULL the link has no setter (read-only), matching the
> existing behaviour. The built-in link getter and resolver are
> functionally identical to the removed memory_region_get_container() and
> memory_region_resolve_container(). The non-STRONG flag avoids refcount
> interference: mr->container is managed externally by
> memory_region_add/del_subregion().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


