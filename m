Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3132F9D0EC
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 19:27:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCjPw-0007zB-Tl; Tue, 14 Apr 2026 15:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCjPv-0007yo-Et
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCjPr-0001bD-NK
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 15:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776194833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CfMFEviRYxVSgXnFCZK/i5XEdKTfWa/C5vJz+vSpgmA=;
 b=eZM1z+RcacTm3DwKsmRgXLdmGKLe6aFmzQMp+FeObF660hzTJXSlJPeUg656dnnxZRielF
 X5m0q6paGQyqwP3RuBwO9PHZAZxoRmLpSo6y9MPd5QEuhdiDlN5XfpWlW+9XmchDmRL7us
 Spto35sRKJqt82plAuDtcDlqVj0aiGg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-182-ywYVBTIIMoiLotwmn1j_SQ-1; Tue, 14 Apr 2026 15:27:11 -0400
X-MC-Unique: ywYVBTIIMoiLotwmn1j_SQ-1
X-Mimecast-MFC-AGG-ID: ywYVBTIIMoiLotwmn1j_SQ_1776194831
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8d3a0ede6faso1172839285a.2
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2026 12:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776194831; x=1776799631; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CfMFEviRYxVSgXnFCZK/i5XEdKTfWa/C5vJz+vSpgmA=;
 b=O0gozNELeAAvdumF/iZJK9R85rUr9+voWks4EJqjB3hXD4SCke8S94ecmAL12vuPaM
 1IkjuQ9EX3xrS1OI2VUD0h5dID+GYzt5do+a7pB71DhB/0uzxLFsBg/eKMVdkXNnjDMt
 l7WK6oktu8thn+IK9jspzK6HS+7bqpGqmlmYc28JA3AEv/RfkomW1IbzQW8F/oRwZskI
 ZD57HvTXuTvSUx5DjL7QWivYWjP/Ue7IcOTlQxrtn44SRX/ui9y1L/Q1S7BX7yKoFBoM
 qQFeYyAv9wx7OPeYvpLayw0KhbNOPNhketBkbx2EH38T3xvX6HeOImcknRF2rICfC+ry
 aoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776194831; x=1776799631;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfMFEviRYxVSgXnFCZK/i5XEdKTfWa/C5vJz+vSpgmA=;
 b=VJEff4qG0+EduLqMoTDhs5WPAwBtoCu0/PiB0lzR+K5ln2ZN0SASDetuQTD+mFdVWd
 W1Gp0wLtgroA/FsBCh8j5B08idznU/ubmXpFe38BmBoinxyI+aqBhj736EfJDCvG1DER
 nRa4hIM3d8GAydNOqfX9lwxaQQt9K2/9tybvb1fnsv/yLwXNNVsVoEpWgOmk3p0mZFBZ
 03od4ipUI6jEBT8FkFSX8PFJ3XU9zonCf4zBxPLk0bQa11i4JlP8l9amn0XVd2wpe/hv
 4XxHMatkQyowyqhyIvi1zd9jYjsGXSTcdbUSOza9KQwhGRFBQfRTWAs1Xv+J38QAuJHX
 HlBw==
X-Gm-Message-State: AOJu0Yybo2gpydwIrulJnkryTbOtZrZkbMGWxw+J7RCQS+IVwDfi2OgA
 0Gwvke8ieL1eso1WMK/l+TZ9MI5V2oma6V4TJfZIYdwweSFBP5n7s9rgY4zhWqOiJ+1sEX5P7wy
 Hz/C5Sqdxu5AOJL+nQQsOyn56Te5d4AghVvN08UoTJ52sMUGy1Xtc0Cn9
X-Gm-Gg: AeBDievV9gBUfZgzgAS8KQ87I30axPvkKPq8jnx0bng2EiJPeNY7HEruHiv8z43jukH
 su5O/AwmeNQEDcXjxNMpRI0/3FwyGpoNV+C5BjtWyzSiUuRQQD9Fqzr+6G7MS1XXdZeUsN/OCSh
 Lt9kYWO2lpfoRim3D0nwpeIjk39w4VbMIJ886OvnE5hQbY3h6dAX5p2Pj3FqGYyPFyJYJDXhxFa
 4duhkN9HaG33kkMviX0519phnX3N0fhRs0d067PWhyzaXmLSKerWthwxtKLtor2cJxofDKPcSZZ
 n+xG9oJdBpJf/TFznKH5YS8XsuGgFLUEkkMm5jWo0ZQkCQDy47DRs39vFBLTnhkIVlDoLg32qRN
 cbf/Dl1zpEqQYhFFtmWD/t5VVLjIMaOJ1TSE7ShJQor+dSLpR9zHENGYAqA==
X-Received: by 2002:a05:620a:17a3:b0:8b2:1ee9:dcfb with SMTP id
 af79cd13be357-8ddcce2b4eemr2826140285a.8.1776194830332; 
 Tue, 14 Apr 2026 12:27:10 -0700 (PDT)
X-Received: by 2002:a05:620a:17a3:b0:8b2:1ee9:dcfb with SMTP id
 af79cd13be357-8ddcce2b4eemr2826133285a.8.1776194829566; 
 Tue, 14 Apr 2026 12:27:09 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8ddb5f8886csm1121233485a.6.2026.04.14.12.27.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 12:27:08 -0700 (PDT)
Date: Tue, 14 Apr 2026 15:27:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2] migration: validate page_size in mapped-ram header
 before use
Message-ID: <ad6VBB5NY2818MeL@x1.local>
References: <20260405094447.11347-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260405094447.11347-1-viking4@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Apr 05, 2026 at 04:44:47PM +0700, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> mapped_ram_read_header() reads page_size from the migration stream and
> stores it in MappedRamHeader, but does not validate that the value is
> non-zero before it is later used in parse_ramblock_mapped_ram():
> 
> num_pages = length / header.page_size;
> 
> If a corrupted or malformed migration stream provides invalid, guest
> resumes either with corrupted memory or crashes unexpectedly (eg.
> page_size = 0)
> 
> Add validation in mapped_ram_read_header() to reject invalid page_size
> values early and return an error instead of continuing with an invalid
> header.
> 
> Steps to reproduce:
> 
> Create a migration snapshot with mapped-ram enabled:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate file:/tmp/qemu-snapshots/snapshot.bin
> Modify the snapshot so that MappedRamHeader.page_size becomes diff with
> target psize. (0/512/8192/1GB).
> Restore the snapshot:
> (qemu) migrate_set_capability mapped-ram on
> (qemu) migrate_incoming file:/tmp/qemu-snapshots/snapshot.bin
> 
> As-is:
> * [0]: Floating point exception (core dumped)
> * [512/8192]: Silent corruption
> * [1GB]: "post load hook failed for: kvm-tpr-opt" (EPERM)
> To-be:
> * All: qemu-system-x86_64: Migration mapped-ram header has invalid
>   page_size [val] (expected 4096)
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


