Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB09CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:08:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utnDT-0003ZV-Bb; Wed, 03 Sep 2025 09:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utnDS-0003XT-1y
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:07:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1utnDP-0001Wl-Bj
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:07:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756904872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vaQTCENLxTOTgYR3oTKuqFdYGsr6IiWkQQSj1YETLag=;
 b=TTuo44P0qbP9CNw+yLhEhb+CFpmHsiMn2R6JZ5WiJ/ZhUACOfPXXxT19xu5Bo/vIB11AbO
 q1mj3bf2PmAj1+iPyqbxDFTFf9qV36e8kFVhTu3t49rKK9B9GNJiK615i9uG3sNggPtz+Y
 0i9V4kUOyu8n9a5jwr1HMoCKg0BUFCQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-727xVynZPJ6zsUoh3bl5Pg-1; Wed, 03 Sep 2025 09:07:51 -0400
X-MC-Unique: 727xVynZPJ6zsUoh3bl5Pg-1
X-Mimecast-MFC-AGG-ID: 727xVynZPJ6zsUoh3bl5Pg_1756904870
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-80593bfe0a1so444810385a.1
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904870; x=1757509670;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vaQTCENLxTOTgYR3oTKuqFdYGsr6IiWkQQSj1YETLag=;
 b=rr/nisi/lkzIcoI9IZRb2Zh340+F+1WYVJ4RUIQ9TEv5yG5J+TIE/l5KbZ8mIVqhM8
 dD3dhYS+wsUUeAUPgiTHVq7NifsVHLAjoeJcF4v3ZmDDf2Q1eaLiQaCcdvE+jp3e3q7P
 g5LaElSstd8nItttPtJlkQCrDvflQgh2CkNl3LQjDibazCkeMJLngwzSuZEqzjM8Gc/o
 GKPQvY7T3bb28et1Te5ibiiskrV7Ow5s7plEgRn66aTy1ERxdScufgPLpbVNkIiAOT4C
 rG2fiPL5ryHmouGV5a5A0WK5aUJpkipQFcrUgdQh0uF9Rw3LWS3m/vZL6Ua/bjart87x
 tZ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0BxY20fHoaCKcQ1R7MmgQofr5VLRuZmeuRMYXNkT9EkMSPUL/V5n9/tEZCHruVOyq5PvF5sA5i3TY@nongnu.org
X-Gm-Message-State: AOJu0YxY0dILm6LFoKD+EKD5Mx8vFyRxL72LWxBz/WeYx1LMjB+wQujS
 0vkaYi1TjIk2NO4YoG5cjBUDXB+3aMLYzpgNjtkdJQhjJhbjENom3EVYXFK3vZ68rrYzEhYpJ+u
 o2Jy+jHbypq0igKu59Jez2/ZDGfkqJHoS3whovu/o/QxFpZ6u8Kf+w9mi
X-Gm-Gg: ASbGnctv77m45cyQHW/gWgB1GM4uJJcSXG/fL6FevavZaZ1n0XnhGrCGRluj1qOxZrQ
 HNIfHLHSfDycIJJa82WPcqrk2JM4kRCpeT+tOiVFAlV5s+i0/ynUg1B/FpFPGyjTAbC6NXeerCZ
 jET9b2hdyjlCJL6MX99pB1YfkgEOmFwvgIIPyVmaH91Ng+OLOebdBx7qBrzedxdVFK8yaciM/Au
 rCeGJZW+3ecPYWy0GlV3azjHt5PQkxNuDo5QJhgPBH9YL3TEFazgBx8/b0xGzhg9wm5iynItB0C
 ea0y2mTgsEw7u8UfizDrjdNdCrPPCY1MfNzvNqvJtV+FxEDDe1o0qoYK0bSzJZwvCKBovtUP94m
 xeg0HoSZNLsaQbmQV2+ibsQ==
X-Received: by 2002:ac8:5a03:0:b0:4b3:48f2:b8d0 with SMTP id
 d75a77b69052e-4b348f2bc63mr69826121cf.59.1756904869903; 
 Wed, 03 Sep 2025 06:07:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGe/vEOFW0qUlcKR5G1KcM5rF0u2X75FgXcws5gDcgpDuRk0m29KurPtQ0yWOX4gta96PHMzw==
X-Received: by 2002:ac8:5a03:0:b0:4b3:48f2:b8d0 with SMTP id
 d75a77b69052e-4b348f2bc63mr69823981cf.59.1756904867799; 
 Wed, 03 Sep 2025 06:07:47 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b48f76169fsm11053831cf.31.2025.09.03.06.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:07:46 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:07:45 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Juraj Marcin <jmarcin@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <aLg9oYlaougF1-dv@x1.local>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
 <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
 <aJ43_JQct45mnVgV@x1.local> <aLXehgy3S5G6A3ub@gallifrey>
 <w6qkokuof6ge2gwajhcwul5boaqf57w6m4yzsbyljpgpnigc64@pw2unqceumjn>
 <aLgtyy_UAfsmOLET@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLgtyy_UAfsmOLET@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Sep 03, 2025 at 12:00:11PM +0000, Dr. David Alan Gilbert wrote:
> So I wonder what libvirt uses to trigger it starting the destination in
> the postcopy case?  It's got to be after the device state has loaded.

qmp_cont() supports the "autostart" variable:

    if (runstate_check(RUN_STATE_INMIGRATE)) {
        autostart = 1;
    } else {

That's since commit 1e9981465f ("qmp: handle stop/cont in INMIGRATE
state").  The commit message also mentioned libvirt used to use a loop
somehow..  and I'm surprised to know it wasn't trying to fix the libvirt
problem but something else..

That makes sense, as any delay on cont would be accounted as downtime (even
if trivially), if only executed after loading complete event.

-- 
Peter Xu


