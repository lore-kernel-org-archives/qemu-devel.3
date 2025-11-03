Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB3ACCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 19:10:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFzwH-0004up-RG; Mon, 03 Nov 2025 14:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vFzw5-0004rg-VM
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:09:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vFzvv-0006bA-4A
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 14:09:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762196973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=84Dxb118fMH+840G+SVxAcPDNQrtlabYjZtVlt6rYaI=;
 b=MkUQ1/p1DQESNyz2yRV6CbHkD8y8CxJEZlMBWjtLPZTvUoT946/OCG6rhZdO4iAz83jHMb
 tL473O+QEODqdCQax9H1cTcBkapGicYh3stCAepN/2nYI/02rqtAI5IhlBbeHsq8AKQBU+
 NEK91Pu9n/eF9M9TfyBZb0qekJUe3Rw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-B4EKTkBfPx-59eediWaAIg-1; Mon, 03 Nov 2025 14:09:31 -0500
X-MC-Unique: B4EKTkBfPx-59eediWaAIg-1
X-Mimecast-MFC-AGG-ID: B4EKTkBfPx-59eediWaAIg_1762196971
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-88046a6850bso67439776d6.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 11:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762196971; x=1762801771; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=84Dxb118fMH+840G+SVxAcPDNQrtlabYjZtVlt6rYaI=;
 b=HegLtKxTrHUBmnMVAtAMYRJ0s4uX0u3fGaeyk7XkPmuedbqJ47B/Ruid5asGNXHgNo
 ouT/PC/YXiVMcLOU3+bDpRKh9ywMyeSIkF/vmsGyo0/k6pX9Hhrd2Cyi2hK3coyROHKU
 LgNsZtG0/G1x+I0+0p9uMe/J/LDvIE9/as1uOH/5lxk0MLgquBBMlDtp8orUK3y/H6sE
 +1lMvqmRRbqmUNjPwzXSbBcxiLFB9Qf3kP0bOP6OvLtdAjlExHtcH+O1G7Hyj4KQmCU2
 ne05AALFCIMMPQu27uqRqkzjixF9e+ztmycb7gD+p9NIqUBq7+z7fj9sF8mty1TLItks
 016g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762196971; x=1762801771;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84Dxb118fMH+840G+SVxAcPDNQrtlabYjZtVlt6rYaI=;
 b=OJYfkbezU7RHTSXrr6SFiWQn4dzxyTrQU6eVEBnIXpI7M7OYk8JyQcB6Dq+aVFjj9T
 gDUzB8d7e1CDYYFU9geLGDHeuisIIlaaaNu7d7TvXdHcnDwHoMmVubtVE2oNIG6OyZMA
 Y9KGBYHHZrDLRlxfnPrpcDQShGpeP6w9Y3YA03YxfK+rgOrpy/E+Aktov2H1unJw+jqG
 u57MZSuIRt53tanvgc+vn/7bARdKdxC/3n8Ny51bA8lEBXXcPWhwDXgmaAbl7mth1bVd
 WJQPi/LbjKDCfTelmz86HkXSdZbQveQFY8UWeswCSUe6tgPDIcYyis2XiqrLf7vDoCXJ
 1MQQ==
X-Gm-Message-State: AOJu0Yz4xO98i7nOdcC6NI73un4w6IkvveSXiWun73VFOWIQUsAEmUvs
 Igh0eMwJm0/XME2E/C5QJpdZq6kmZ0V83r8v1/Mx5VTjEDQDeuKoChURxNAn9c89DHdo28sPtlj
 tPFtlEe2cgKKLmImadWJoPKm9PLYoVHEMWfr0LB6zXXFp+9NEiID3QEoB
X-Gm-Gg: ASbGncuh84SdzgeGRgL3ywHrXBXNdQ5MxIzMYh63UDgwUobXe8UiIMQF2B3zAREbp61
 pv/zy7vWUwVpZrdLIF+t+6uepn+RV40NpaTqkfRQ/0J6mAq5qQmCV2Sui7qskRgNfG2qWuXkpjp
 5ryHG3NLsXRwx5GkZtp8kEAuM7CdoA3yPX8LBSLClta/Tj75QVTwo/XrxxO2nYO8BnWuGdqcN7n
 /wgTIvQTcNQblplKLCGCIRLYk4aNfW7iziivS0wBvrRpVHc6YMh3f7cNrYLjpJDOTgxv8ilRbqA
 Dph6RIjB47V+iQK4MDAEFzJFMp57oXkmdtT7m4HQvjOnBqZKRG9PU8H8Sg4+t3pXcc0=
X-Received: by 2002:a05:6214:2387:b0:72e:d34:573f with SMTP id
 6a1803df08f44-8802f48d312mr201546986d6.39.1762196970482; 
 Mon, 03 Nov 2025 11:09:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGI/5S4byDRXp27iqRCfpVA1/lT1dRhdDNB1BUKXuVw4fAAmKE6W7Z80xeYdbtggdmRLgr4cA==
X-Received: by 2002:a05:6214:2387:b0:72e:d34:573f with SMTP id
 6a1803df08f44-8802f48d312mr201546556d6.39.1762196969984; 
 Mon, 03 Nov 2025 11:09:29 -0800 (PST)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88060ea9f54sm7473726d6.53.2025.11.03.11.09.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 11:09:29 -0800 (PST)
Date: Mon, 3 Nov 2025 14:09:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>, Jiri Denemark <jdenemar@redhat.com>
Subject: Re: [PATCH v4 8/8] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aQj95wuc-UtJEKXo@x1.local>
References: <20251103183301.3840862-1-jmarcin@redhat.com>
 <20251103183301.3840862-9-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251103183301.3840862-9-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Nov 03, 2025 at 07:32:57PM +0100, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Currently, when postcopy starts, the source VM starts switchover and
> sends a package containing the state of all non-postcopiable devices.
> When the destination loads this package, the switchover is complete and
> the destination VM starts. However, if the device state load fails or
> the destination side crashes, the source side is already in
> POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> up-to-date machine state as the destination has not yet started.
> 
> This patch introduces a new POSTCOPY_DEVICE state which is active while
> the destination machine is loading the device state, is not yet running,
> and the source side can be resumed in case of a migration failure.
> Return-path is required for this state to function, otherwise it will be
> skipped in favor of POSTCOPY_ACTIVE.
> 
> To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> side uses a PONG message that is a response to a PING message processed
> just before the POSTCOPY_RUN command that starts the destination VM.
> Thus, this feature is effective even if the destination side does not
> yet support this new state.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


