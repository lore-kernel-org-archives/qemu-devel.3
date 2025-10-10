Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43CBFCCA476
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 06:41:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v76nZ-0001B4-Vf; Fri, 10 Oct 2025 02:40:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v76nX-0001Aj-9g
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:40:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v76nR-0008Kn-89
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 02:40:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760078403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K04pWNRa8/KNRUK7EwfS+tswXFDAnq173LnY5YsDJWg=;
 b=KfyPvahDPczis73mUJkB9S9i2kgG1Drx8QODU0ghityWDfhYT5iXmfkzcP4FaTu38DQYww
 F3t6Smli9K5NEPNsZ4cACNQ+aR1kSOekanAj8/BGHA9lDgmu3a7qpNw2lwjbG37bPuZWR+
 dYkyahTt8TkrN3p5bayne/as68HEoCc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-AHWF8E1rNva6AUJgRi-lBQ-1; Fri, 10 Oct 2025 02:40:01 -0400
X-MC-Unique: AHWF8E1rNva6AUJgRi-lBQ-1
X-Mimecast-MFC-AGG-ID: AHWF8E1rNva6AUJgRi-lBQ_1760078400
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-634779072f7so2469368a12.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 23:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760078400; x=1760683200;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K04pWNRa8/KNRUK7EwfS+tswXFDAnq173LnY5YsDJWg=;
 b=dV02USSgXf9Efusq/PPHtb1GPvbbMEr+mE3l/7d3PgP95mDX9mGX89d9pV7T0VrmOi
 3pc2zz/sf8ODItFlXBcFsCR55ftGMP4XmUwV6POKUFGj0g/s0cDYwM/eVVsRGH3vA+/L
 KH+uTNaFLW/7m6R+vuIH5iym4ujqWr4jdh0O/QckxtCtCfiRw8AkvUNSODz7sMBot6Jt
 9TlXCj9pv6SWQLnjxf5RGT1HNWNe6eVJITczHE+y2SZvfTWhwB3MzSB6+nCzImHYMtin
 ATiqmudAEwG5Fsriej5Fcu8LW3ncUGoWzQmwQk8bY+vF28m3Q55H+0+WCTmtIbsMBBGB
 sd+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKeW1VfgF+i56k9RTnf+rI32odndAL1jREpOHv/KY3qDi1QvBzwBicSld+VQUDarDc7HjF6E3/72U+@nongnu.org
X-Gm-Message-State: AOJu0YxksvAKST/DgWeO5JPpZW1JRiltFBlcIqzP/yzO5E7ztb9bC7QZ
 qCpBReOgVp8f+ZLxeC73nlojvUUc4CDhxXMCvdCstpRQ8+LFbNPLZjmVgzYr2kFBlc9gCb3ilXE
 /kP18aPcJsQGzFFn/rfD/dL2RD4pRa1WumvuMnpzOwbHTqSP7G1lXVo+3
X-Gm-Gg: ASbGnctJfD2iefDRcrUNWd5oCdYJHu+pshmMIjLg3mPBM+uSU3Bmo9gKb4ADdHjMxv4
 v4WP+C4QT2cbtQcqVep1oRC25w291XXZjBQKVE9NPvkIZQPcS2SsHM+TLtI2yujYk/yugNSWerB
 7X0SKcGs4mawl1N8MydPg8c2Vq1RmUmySRVqayveVnAriqzQxy7odokNNsYLRg80NlRrjKyXS+0
 vcSwUOPL+F3lCik12vtmioiGMLCjeC7YU3WRRuHm9Bqu6WK5fnjY2VZL2PYlPT2POlez5Lw0n/G
 l+nLXFCT9z+UY91l3PkOQxYBCLbZ
X-Received: by 2002:a05:6402:35c3:b0:639:fac4:bf35 with SMTP id
 4fb4d7f45d1cf-639fac4fb33mr5209638a12.12.1760078400454; 
 Thu, 09 Oct 2025 23:40:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGANkVzLgolIT9WHI1gXM2FNmKt1wiPEChAKWr6Rl9Z7H6T+q4xif8w/lQlQ76UfhkKTN7NTQ==
X-Received: by 2002:a05:6402:35c3:b0:639:fac4:bf35 with SMTP id
 4fb4d7f45d1cf-639fac4fb33mr5209624a12.12.1760078400093; 
 Thu, 09 Oct 2025 23:40:00 -0700 (PDT)
Received: from redhat.com ([31.187.78.21]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm1502419a12.39.2025.10.09.23.39.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 23:39:59 -0700 (PDT)
Date: Fri, 10 Oct 2025 02:39:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com,
 richard.henderson@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, santosh.shukla@amd.com, aik@amd.com
Subject: Re: [PATCH 0/2] Cleanups and fixes (PART 2)
Message-ID: <20251010023917-mutt-send-email-mst@kernel.org>
References: <20251008164324.21553-1-sarunkod@amd.com>
 <e0cd4386-c367-49f0-b83d-6c38cc6eeef8@oracle.com>
 <0f6dbb37-9d00-43da-9807-c0629575cefb@linaro.org>
 <29d20903-e255-4398-90f3-5e04391a46fb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29d20903-e255-4398-90f3-5e04391a46fb@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Oct 10, 2025 at 10:55:45AM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 10/10/2025 7:49 AM, Philippe Mathieu-Daudé wrote:
> > Hi Alejandro,
> > 
> > On 10/10/25 03:33, Alejandro Jimenez wrote:
> > 
> > > I know the commit log is not consistent so far, but going forward I
> > > propose we adopt the shorter prefix "amd_iommu: " for commit
> > > summaries. There is no ambiguity (only one arch has amd_iommu), so
> > > the full path is not required (i.e. avoid 'hw/i386/amd_iommu: ').
> > > Shorter boilerplate leaves more space for relevant details, and
> > > helps people like me who struggle to comply with character limits
> > > :).
> > 
> > What about "hw/amd_iommu:" to keep 'hw' in subject?
> I also prefer "amd_iommu". But I'll wait for alejandro's reply before
> posting V2.

If possible, pls use that prefix on the cover letter too.

Thanks!

-- 
MST


