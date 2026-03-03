Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32AEAEDEBF5
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 21:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxXLQ-0000H8-Pe; Tue, 03 Mar 2026 16:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXLP-0000G7-FN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:31:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vxXLN-0008Fb-RE
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 16:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772573513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XZuCvC0jKVdp/Y15R60BLqARNhNm25a0ww2zpI2Lh28=;
 b=FNS9YTVmwt4IdlfE/f1DtmStvmlfLr6hj2rbe/GyXi9E485cjL2QSdqkPiMDTRoieT8H+C
 mOhmuLo7u16NHCnW0Q1QJOirW5/Q6pJ918ZfD4DLZoWMSgidk+qBNZZlPTy9zVObRCI3et
 w2zA64xxHsM4hWo13dtjleN5JvwcZxI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-5IuBS_uxPrOSkMQJv9u8Pw-1; Tue, 03 Mar 2026 16:31:49 -0500
X-MC-Unique: 5IuBS_uxPrOSkMQJv9u8Pw-1
X-Mimecast-MFC-AGG-ID: 5IuBS_uxPrOSkMQJv9u8Pw_1772573509
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c882774f0dso3999359785a.2
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2026 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772573509; x=1773178309; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XZuCvC0jKVdp/Y15R60BLqARNhNm25a0ww2zpI2Lh28=;
 b=WLYX1tRdVsGbhUHVUORsScq2ug1Xs1uHiK3jjnCnXhyYOEDJI8WohXyQMGLuN9IwRF
 GBDfYacyYUJ7pHApiCvRmXj9FiSnmJN5GZALDdF2Smn/NVKNE0DouloZojiUcA1j0iVj
 N5Ik71wYz8BnBXnk5EXvNts6JPiGC0WHQKxomWs77pSU54cL3zdXRwbOa6EJybBZqzRV
 CSn4IdNJiUcU7bR8WSkz7t6BFpkfKQI1UwnvM1UiEkL8sJXEGFDwmDM+XPca5lYCmJRO
 vCCAiWswIOokxS3dut3EEy45zAPxKno4yOWIThgJkhLMfO5May1lcpqOwZeU+wobiGwU
 Yngw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772573509; x=1773178309;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XZuCvC0jKVdp/Y15R60BLqARNhNm25a0ww2zpI2Lh28=;
 b=Y5Ou8bzuRidj9ccID2ZqU0LZBsvIsN1wIZxcXqojdwDTFoxrxeu1gaFucUn0VXWyLn
 6UIcLgRQOuyQSab2AH4sq88um1ztpu/DM62tL2YfvWzhzghMLRGLHhI9II7VyQ6D9FEl
 g0+B0QuJfA+pcA+3ChG8+HqYbLpTAYN5jrnNygtAb13Sv+9l4h+3O9NNaCISw4/YL/Dc
 brozDkZAKfKnor2LGUpR5lOt/a7Tl1hLZMvjLo1NQLmg6CyuU1bfWqEJW3HmYp9xnWxe
 Gujswc2FniFPOaNsmfa1B7DQsNNVjTBCngEaMW59ng+MM+dY2b2bk6oxSt04L7e2DJtI
 5w0w==
X-Gm-Message-State: AOJu0Yz+cpfjGRFtDGwhP4n0oz8zf4hr+mujxeRBaTJrwQjRXawKcCfN
 DMD0BDIU2+G/S2IkjzEPdhmKhIRzymeSc5vfk/fMZ0FujO9Z/YciN0LZlm10a0KvwBY6ngjoksR
 Z6uljmHyOoBeywSwhU7199deEcjG9edMEJzVvhuoBStVYaXCeZ8Ip2Zeh
X-Gm-Gg: ATEYQzxohAifk/3OqAS1Wdtj1v6dd0yDwdXy6Zu0xYJEjzodj6bN8oZre/DAYR0rlC6
 BMG44VRlpdGvfZkClei2vS8Z55m2ff4JtawfQ1UOA84XaC5U5qUuYdOIF1Hn1W7QZ6omUbI2i3Z
 L5hZJdsjw7a81tCM+lDAFpJufnKVLa9gPd176HSgHfB+WROg6KGXVehkJBJXmVqBr1zLJ5FihLT
 LiiBVMaIEupIzKiAn7Ue1FSJ45O6v+e8h+S0cXH++VEsqZyscGsw6x3IhIVLX8V1C2t8N8RNBGD
 MzlxSafBfFB5eNW7OxXUtesujbcqCuRqNLJ5PQKChRsABZ7KzyiUenjXHBVh2joyWSSlm4wFzSB
 5DiuqmXFr9NoVGmQcne6U/d0Wp4QINPvdY27vzVH+zWGMgDvTAxBfdzqw2gnmw9yJogG7R1SZ/W
 /91s1idw==
X-Received: by 2002:a05:620a:f0e:b0:8ca:4438:b91b with SMTP id
 af79cd13be357-8cbc8e080d0mr2163100085a.57.1772573508862; 
 Tue, 03 Mar 2026 13:31:48 -0800 (PST)
X-Received: by 2002:a05:620a:f0e:b0:8ca:4438:b91b with SMTP id
 af79cd13be357-8cbc8e080d0mr2163096185a.57.1772573508284; 
 Tue, 03 Mar 2026 13:31:48 -0800 (PST)
Received: from x1.local
 (bras-vprn-aurron9134w-lp130-03-174-91-117-149.dsl.bell.ca. [174.91.117.149])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf6f93b5sm1469301785a.31.2026.03.03.13.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 13:31:47 -0800 (PST)
Date: Tue, 3 Mar 2026 16:31:46 -0500
From: Peter Xu <peterx@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Ben Chaney <bchaney@akamai.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Mark Kanda <mark.kanda@oracle.com>
Subject: Re: [PATCH v3 13/15] system/physmem: destroy ram block attributes
 before RCU-deferred reclaim
Message-ID: <aadTQkmr4yscUpyr@x1.local>
References: <20260226140001.3622334-1-marcandre.lureau@redhat.com>
 <20260226140001.3622334-14-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226140001.3622334-14-marcandre.lureau@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, Feb 26, 2026 at 02:59:58PM +0100, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> ram_block_attributes_destroy() was called from reclaim_ramblock(), which
> runs as an RCU callback deferred by call_rcu().
> 
> However,when the RamDiscardManager is finalized, it will assert that its
> source_list is empty in the next commit. Since the RCU callback hasn't
> run yet, the source added by ram_block_attributes_create() is still
> attached.
> 
> Move ram_block_attributes_destroy() into qemu_ram_free() so the source
> is removed synchronously. This is safe because qemu_ram_free() during
> shutdown runs after pause_all_vcpus(), so no vCPU thread can
> concurrently access the attributes via kvm_convert_memory().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


