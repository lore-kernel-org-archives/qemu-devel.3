Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0857AE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 17:49:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQ91J-0001dv-TD; Tue, 24 Dec 2024 12:48:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ91H-0001dg-BI
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:48:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tQ91F-0004Rd-K6
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 12:48:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1735062512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5htcbXCEDIMhIFlvBWQu+Qt2xY+CeA28cxfAhURGUis=;
 b=bmGA5Kdl+RqGagvjv6jr5rGcc+PuLADljPPNo0TCfYPi0fsI2uDphlkPmhVVAfnhYDGxXR
 nj9GTE4j+e9ZlslRcHftU+XVrasiL04rBNFvBX5F/naGsBMF3PoZcpqDJVv01IwIxhzIhc
 WLLRMP76BW3uCzCqMrg7WlIVi/FmI8M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-k6ole87KN9WiS52_0dWsJg-1; Tue, 24 Dec 2024 12:48:30 -0500
X-MC-Unique: k6ole87KN9WiS52_0dWsJg-1
X-Mimecast-MFC-AGG-ID: k6ole87KN9WiS52_0dWsJg
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6d88c987fc7so95271286d6.3
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 09:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735062510; x=1735667310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5htcbXCEDIMhIFlvBWQu+Qt2xY+CeA28cxfAhURGUis=;
 b=szPKOsnopiKimatxPaqGMa/EEGYcQVGLuZWZFf02DCjwjUgaU3QZU3FG0vnhVbEGcP
 SAP6tzZuI1B/7Q+dBoCf4k9UzUWgtCwUvkVAXXsgw7yx8pjrL97AIhdKlDzQF1Ic7JxG
 Ahcy5poFI2MxwZ6bjMgcG5Su+R1a6exNthGsZKnGQdCJoMSriyePeGF6jKZ7Lv9gcMyM
 CZbtMOpVvLsTcwrBZX+RWX6iCxRmz7sRh9tld16rAU+AJFt588CL+m2K83aAsmW8e0Eu
 MDrvwqa3+dtbCE7FjyRYl22a78xHHJT2n/5mcGFvOApwk5+JBehg6EVbi2Rfj7LFD/8v
 CXNQ==
X-Gm-Message-State: AOJu0YzZG+sRRl2/mYYfsOiXqB+YpqvsOr6U5oO08RWmhIyIM2xPG3ad
 iKG3IGXUn1df7GUIQRocDy2hZkqzeeDeGc02c1lt0HqRtZEw3Ijijj7fKRdNHyKb7YKFsYjDakZ
 9Bn/NY5GEZg8tvQiwqiny7vmpcTKfrOZ8o4Y1f1PxZRRMxPpNqY14
X-Gm-Gg: ASbGnctVPJePIXfhrroKb+lHNWJsuLPkM1mtPWRocd6+44sOfWaJ9InGxToSaT2SWuE
 PPMxUzddqiljYC99jLDYb1wcewk81bBJ88nAvN0JRVagOJSeEp5/3I3bZcLca//dTPNRNfXzmqQ
 BWcMLENhwnDgj5fwxqhTGlbxBbBWgGMslS6Y9eUxsyUatvKqJez6Dt0Tk1V+1VIPTHTzmerTG/7
 8VTlWRqYrYVrYEaUBrn9EChWf4c4zInKzBcv1qvpWtEI3/+S97owhzXn1Ne8L5rP7ddOJANyExi
 R8SehlthMEoI/iR31w==
X-Received: by 2002:a05:6214:3001:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6dd2334b2e5mr303360276d6.21.1735062510032; 
 Tue, 24 Dec 2024 09:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHVRIyabMweCvLDraQadffUDmzp+5tc1e3+fz9RtCCcejw7lFvRNNaegjtWoD4g2/nxPW4g+w==
X-Received: by 2002:a05:6214:3001:b0:6d8:d79c:1cb2 with SMTP id
 6a1803df08f44-6dd2334b2e5mr303359966d6.21.1735062509773; 
 Tue, 24 Dec 2024 09:48:29 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea69dsm54816786d6.24.2024.12.24.09.48.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 09:48:29 -0800 (PST)
Date: Tue, 24 Dec 2024 12:48:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V5 10/23] migration: enhance migrate_uri_parse
Message-ID: <Z2rz6u8aeC3L2Ad-@x1n>
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-11-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1735057028-308595-11-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Dec 24, 2024 at 08:16:55AM -0800, Steve Sistare wrote:
> Export migrate_uri_parse for use outside migration internals, and define
> a method migrate_is_uri that indicates when migrate_uri_parse should
> be used.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


