Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39020C35FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tt6FO-0000mx-MK; Fri, 14 Mar 2025 10:42:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tt6FG-0000jq-CW
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:42:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1tt6FE-0000j9-5j
 for qemu-devel@nongnu.org; Fri, 14 Mar 2025 10:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741963355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QIEpXX/bVXJjXBXRPS2BKidefvabtH9oOzho8bUO/5o=;
 b=dhlbrscRvvw5R6y/YWSCOa0FpkodEJZ/8+MqwyEOHyDr9icwvxaX5IytBHS10o0BevzVpN
 mJ5zLrBPQvg8oAt7euAPZQGgI8B15t5zH4Vsv7fpSyGce3yoihalIb02rOaiL54iO7ZpI3
 mRhPksDO4/9wku8OETEEogOBik8LvvU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-jJopZxI1NbyLwuzLjtFwSg-1; Fri, 14 Mar 2025 10:42:31 -0400
X-MC-Unique: jJopZxI1NbyLwuzLjtFwSg-1
X-Mimecast-MFC-AGG-ID: jJopZxI1NbyLwuzLjtFwSg_1741963351
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8556de861d4so35679839f.1
 for <qemu-devel@nongnu.org>; Fri, 14 Mar 2025 07:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741963350; x=1742568150;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QIEpXX/bVXJjXBXRPS2BKidefvabtH9oOzho8bUO/5o=;
 b=MIzyLqzNmda8UDrrYwXP7FeFjgVqd+EVzw3m7LkHTSvewZw1at757nUamO0rz9d9Rt
 VIR4I7wgcVl9FeUKN9RNmiSAaEzgxSeFzlBYef0CcYq7yiDnGxx/ySlRsUrPCZ+0fpQW
 nAaBpcnNByRQ85c2pUE9FiSgyMRAvlBxg9z/JEo5292mZzUhosLc2TrgAhsSVM5uBt0l
 VpCwwghq6hkDW2PsNi0LzCMnBzQYKlIFQZLj5irCMdu4Tru/J8HdmemCxiAuvWAWhY/9
 jf49++BuOCvVrnsz+dwywlA5RsQvMGJyxUzVlz2mxKA/s2jx73X517F/21k0bQX0+vzN
 Luxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTr4CvCwyjiWRJTnQacVa6eGrbJbCIVBqlQE2DAQaotQE5rFdL0SV1ieI6/3TJO2j96SOi+iKaEQLu@nongnu.org
X-Gm-Message-State: AOJu0YxM7fipGukXMWDeqe/mBYHzXByIrlVmTP70pu30uHzm3zkzT68W
 QnAVFOoBgDKgPSSZLPjiKVf2XbuoNRmRt1Vh7SXvwnEyBGtfigiWubwOBN7eEU73AZDBjpKmOL7
 iT4Lp+r9OdrshrcHC08/UUk+VHPppffRSXRmia4AMlSMLPjsXmDBykR/Il9QF
X-Gm-Gg: ASbGnctlZKlE/EymDvSYz4vlb0npETyn9c0xLgp/BPwAP8Qj82Ls03kpnHtLdkYu1z4
 AGz/xcKudxgMEcT7lgmX4ZpTMVyuh7T3XtUJMyiBd/fPj7wbhSb071sEfHGsqOFr5xQyqtkMSuY
 avAd6hEwwv7h53fUGNQeXTnCDiR72PcdQ4AKvDlpRoGfK0iSEIpWdcjgUoBriEh/Xzed1lPa/BB
 Izpa8Zo8Vq4p2nCLQEcrLpmGMRVEf24/8zBpuD4C2MWc0d+qiDg6wWNTXzjSxrASHXOUTGzXhmZ
 EJF7ixUhx++GovT1cXc=
X-Received: by 2002:a05:6e02:3f90:b0:3d4:29b5:dc0 with SMTP id
 e9e14a558f8ab-3d4839f5d28mr6092665ab.2.1741963350369; 
 Fri, 14 Mar 2025 07:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeqsxTJOSasJ1hsNODDbAjIyMNLqQVfMoZEWYe0uUqu8opISNx7z87gEs6TWiVFTw6MOa4Mg==
X-Received: by 2002:a05:6e02:3f90:b0:3d4:29b5:dc0 with SMTP id
 e9e14a558f8ab-3d4839f5d28mr6092595ab.2.1741963349727; 
 Fri, 14 Mar 2025 07:42:29 -0700 (PDT)
Received: from redhat.com ([38.15.36.11]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f26382a77bsm896999173.141.2025.03.14.07.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 07:42:28 -0700 (PDT)
Date: Fri, 14 Mar 2025 08:42:26 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Tomita Moeko <tomitamoeko@gmail.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Corvin =?UTF-8?B?S8O2aG5l?=
 <corvin.koehne@gmail.com>
Subject: Re: [PATCH v2] vfio/igd: Update IGD passthrough documentation
Message-ID: <20250314084226.6fe30233.alex.williamson@redhat.com>
In-Reply-To: <20250313150339.358621-1-tomitamoeko@gmail.com>
References: <20250313150339.358621-1-tomitamoeko@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, 13 Mar 2025 23:03:39 +0800
Tomita Moeko <tomitamoeko@gmail.com> wrote:

> A previous change made the OpRegion and LPC quirks independent of the
> existing legacy mode, update the documentation accordingly. More related
> topics, like creating EFI Option ROM of IGD for OVMF, how to solve the
> VFIO_DMA_MAP Invalid Argument warning, as well as details on IGD memory
> internals, are also added.
> 
> Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
> ---
> v2:
> * Fixed typos
> Link: https://lore.kernel.org/all/20250312155002.286841-1-tomitamoeko@gmail.com/
> 
>  docs/igd-assign.txt | 265 ++++++++++++++++++++++++++++++++------------
>  1 file changed, 196 insertions(+), 69 deletions(-)

Reviewed-by: Alex Williamson <alex.williamson@redhat.com>


