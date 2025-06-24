Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3204C77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 10:27:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uU0qt-0006mL-TE; Tue, 24 Jun 2025 06:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU0qr-0006m1-J3
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:26:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uU0ql-00008n-J6
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 06:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750760757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=72N5xfQM4aa0Fc5JdZLxGhpO1UEcvjqw03VHb7V5pf4=;
 b=JePUu0KTgSr7u19lowplt2WSujjPFJrnNPu0QPGe08g33kYVrQqxiNDQ/MnHGwlmvFvRDF
 NVwAL83CwHfb/aXIXNT19MLhNp5G8EfKZQrz8h+QVRbmsVpg6/lLsBg4WQEobAc0pI9kfD
 g6w8PBLfJJY1tBzNfwPTBreM7oKm8pM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-tYN0Q2HROiSRiCJmx0Ypjg-1; Tue, 24 Jun 2025 06:25:54 -0400
X-MC-Unique: tYN0Q2HROiSRiCJmx0Ypjg-1
X-Mimecast-MFC-AGG-ID: tYN0Q2HROiSRiCJmx0Ypjg_1750760753
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a4f7ebfd00so147665f8f.2
 for <qemu-devel@nongnu.org>; Tue, 24 Jun 2025 03:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750760753; x=1751365553;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=72N5xfQM4aa0Fc5JdZLxGhpO1UEcvjqw03VHb7V5pf4=;
 b=sv+bUAZBd3/mX/q19idj0BFrido1u19iNHBVZ45KvwtRxMd79gMLPriwW997u1U1Q5
 cWiLz2aQ+MMV/c4K91NZ/2pd6FAHu0sKnJDcmJFEDt5cgu0n9XWksk6bnsAUJfrFIK5h
 WWxUVRkR59Z0TQrDnaUE5RAutRzCEbFtAUdHdynkKaup8oG1o/PxQ5/Vwydmty1bId6/
 Jz6yoRXXMCES95ZtCews7JCaK9rpsIHWARpYghDQDMdTtLuu1fPhQlRb1CF71pFZX4NW
 46LGI73jQvZMIeXsk3lvxFIZk3B4qTJUmRwCzoGLYmz1WKj9O87YVYNvWDXq94gCWuFT
 ouYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtSPXD6wUf67wm1TJyjJKd6WaG4ov9xfMsiDFbu6BRLMZy3VwNB0bySexSB/8AO6lapkg/jov8dsD3@nongnu.org
X-Gm-Message-State: AOJu0YwpuoL9Y7ZlHG3eyD8aR8o0/a9AQpF+NRomzZXn5vAXDrziOCIj
 3DRdPvyGxJDM66iNWRVQKciq9n9kehK7bX+LJ44bkpdZ/z0HnEI9diAAkjUgKZ2pwXDcpipZWBS
 Cz5CYcHz2kqQvGFj+obtB6NbezuxRm+wGKMPjTIfTVU8Rf/SY+UCVqkNf
X-Gm-Gg: ASbGncvY+CxjVXI7F1NbInytkMg6UXJ6u5dbSvWwpUEYQzJX279nUk27gX5UaG5M3y8
 x2iEOEX6YDNWuX8uPQc6eYuXBAIvBFnBFnv6W6a3z8reTUFLPACnV0eB3JIy1h4OMCiYxOKiAmQ
 PNtElam4m95roDAJbkasuEur8JyrFxZJcDYWapFz65jiJtuyfH/cjqzN7Cl1s7MHlz4xaa94s+K
 NeQ8MxWoDKwFpSqvczXJP0Hl8W0JBpz/Ph1UYV07zqag3nKkfI+qYq9ebYpAHOgdjudFtcyzR2W
 ojRtpTAkTxeZYs7XgaeQ/GAldVQpPK6WRc6eq/WmKWe+nBJUjm/9WRPiybf/iYw=
X-Received: by 2002:adf:9d92:0:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a6d1330e96mr11937245f8f.55.1750760753338; 
 Tue, 24 Jun 2025 03:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmGM+gO2HZMUGFu8N6DeSFf/cQL2gN5aY3GaYk4ZugRBZCuKf+MSj+kuiOUUE5PYzZiU05Yw==
X-Received: by 2002:adf:9d92:0:b0:3a3:6e62:d8e8 with SMTP id
 ffacd0b85a97d-3a6d1330e96mr11937222f8f.55.1750760752969; 
 Tue, 24 Jun 2025 03:25:52 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-198.pools.arcor-ip.net.
 [47.64.115.198]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e80f259dsm1600287f8f.50.2025.06.24.03.25.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 03:25:52 -0700 (PDT)
Message-ID: <146a0cb2-e75d-4f2b-a1ef-c681185a6c16@redhat.com>
Date: Tue, 24 Jun 2025 12:25:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add SCLP event type CPI
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>
References: <20250616140107.990538-1-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250616140107.990538-1-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 16/06/2025 16.01, Shalini Chellathurai Saroja wrote:
> Implement the Service-Call Logical Processor (SCLP) event
> type Control-Program Identification (CPI) in QEMU.
> 
> Changed since v5:
> - Add identifiers as class properties instead of object properties
> - Add description for all the class properties
> - Remove S390ControlProgramId as it is not needed anymore
> - Update description of system_level identifier
> - Add Reviewed-by tags

  Hi Shalini!

Thanks, I've picked this up for my next pull request.

If you've got some spare time, could you maybe also look into writing a 
regression test for this, e.g. by extending one of the tests in 
tests/functional/test_s390x_ccw_virtio.py to see whether the guests provide 
the expected information via CPI there? (I hope the guests in that test are 
recent enough for this feature, otherwise we might want to update them)

  Thanks,
   Thomas


