Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBF5C021B1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8Tg-0007Tc-KW; Thu, 20 Feb 2025 10:28:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8Te-0007TS-MG
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:28:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tl8Td-0000Ph-7S
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:28:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740065315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CqFCCPUcHx8mm9DBUzjaWMyFQizkNkpxtCnxaCmEc/Q=;
 b=BlLH4w9gikcPruokNJfUeViqZ2QkTPrwNyocRienAIW/6qSxElAjTwyHNUi4S/CXBi9IEe
 aSxu7eWPZwRvybHFzNW63Y+WYEmlcn5j0mGzn4VxefpHIc541ZvaAKU7JuOf877PdYY6Vc
 4lCVQ/FomhR7CoK+Dd7QD6161mOLRs8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-yDBrPa08PQKibG6VUI__Rg-1; Thu, 20 Feb 2025 10:28:34 -0500
X-MC-Unique: yDBrPa08PQKibG6VUI__Rg-1
X-Mimecast-MFC-AGG-ID: yDBrPa08PQKibG6VUI__Rg_1740065313
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab7f6f6cd96so174235966b.2
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:28:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740065313; x=1740670113;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqFCCPUcHx8mm9DBUzjaWMyFQizkNkpxtCnxaCmEc/Q=;
 b=ZknvwffagcBjR6MDRKNxcvvmWQ35mQopNsEc2lmCYSHaIQlX30hOXbxlWpqEACs2mT
 cpCSbH1YpHh7HDCPrNJvRz/Q0dfbsNQNAraGp91+PndNHo3GLHmAthLw8opPLhAJhFsW
 6OW1vv6cFF1ZdXjhflbTVOMCYD4OX88iQbJqwgVpouabaLh4SjIb9Wth5MM4Q7AWDlMm
 D4jFwqfycoOAY8n3cN7YATVprwlCYx2CfGCIpLqB0YR59sYjD4SZ7XPmkTYqFe+dIiFZ
 uyZ15nyUh7uMtpnR3KgdCdwFjf3WOLbx5ynsERf+LCEmnVnML5KZZGjNf5i85r3IMSvD
 I/2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuy+l5xhvH2o/9E67ykXp9tcEKh1LIvFWitCsAZwadx2w5c0p1qSsZFIVPINFyck4BHkAGaETYSvlW@nongnu.org
X-Gm-Message-State: AOJu0Yx4j5bBrnaKF4XaMb+wVzbL73hH/u6O8dKxwRWhKYcsb4mVRb4V
 9CGgGvUukSM/Dd0Qn7WW9uVaxg67RQzIdQWwRTJnsEx+SBfg9dNjgVSjg91//Lhwp15E1RPbZjg
 f2D1uB9Tg2vJNmvFQpLOhCFZDHhXGXG+mhxcoKbIuGdcJngHnfTmw
X-Gm-Gg: ASbGnctaCuRkVeverlCkQOSAeH+nY4o74Jityyk8sIRyiw/owUTEXVJLWVvIWifqXef
 lUKX7yNwiN8d8XFFt8eYC+FSPjuXcjOZWQj5gy3wtnAqTIbwZjyqkOOEIcQIK2p4KQ8Yj3pisk5
 c5RTHONsmo4kZHVw48nYXQNMbzhfDK34EfdZGaG/17Fyo0ejgZDouBUXZNqIq2rScrC0vk/MVft
 ZqSERcOrSFVf2keKpeuwlKi+meaIL0+bBW7Hruq/sxjb06G+/SQVyu+W33ckwOE51sgKg==
X-Received: by 2002:a17:906:1db1:b0:ab7:b84:544d with SMTP id
 a640c23a62f3a-abbf384ae0emr197598766b.22.1740065311432; 
 Thu, 20 Feb 2025 07:28:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJpsp11wocZRTiCuvmPZc8aQ1kzW8JZbd6CY0O0Zd+1cIAY4hrz4yD8q4nQ7w/MmFPHzkI0A==
X-Received: by 2002:a17:906:1db1:b0:ab7:b84:544d with SMTP id
 a640c23a62f3a-abbf384ae0emr197597766b.22.1740065311048; 
 Thu, 20 Feb 2025 07:28:31 -0800 (PST)
Received: from redhat.com ([2.55.163.174]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb84e8cc53sm994204066b.62.2025.02.20.07.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:28:30 -0800 (PST)
Date: Thu, 20 Feb 2025 10:28:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Thibaut Collet <thibaut.collet@6wind.com>
Subject: Re: [PATCH] vhost-user: Silence unsupported
 VHOST_USER_PROTOCOL_F_RARP error
Message-ID: <20250220102724-mutt-send-email-mst@kernel.org>
References: <20250121100029.1106973-1-lvivier@redhat.com>
 <3mcx7u456pawkgz4dgf6tvk7izczuy55guipqacqkl66jhtltq@fofd5u3el4nj>
 <20250122085828-mutt-send-email-mst@kernel.org>
 <bfc3rstsxuapkjlea4lia3bn44rt7hhsf6kagtkltfssqynx6z@4dodvso73pel>
 <044af96f-791b-471f-ae90-c17597445fd3@redhat.com>
 <kt2sdfv3wg3raylqfmphrdbc2isex2q3jtmgw7oems5xysex4f@lnp3ulutpt6f>
 <20250124170327.448805ad@elisabeth>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124170327.448805ad@elisabeth>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.457,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Fri, Jan 24, 2025 at 05:03:27PM +0100, Stefano Brivio wrote:
> But I don't understand why we're leaving this as it is.


So that people notice if there's some backend problem and
announcements are not going out. should help debug migration
issues. which we had, so we added this :)



