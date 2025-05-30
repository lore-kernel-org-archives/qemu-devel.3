Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE208C5B543
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uL5rU-0000vA-Jt; Fri, 30 May 2025 15:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uL5rT-0000v1-G2
 for qemu-devel@nongnu.org; Fri, 30 May 2025 15:57:51 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uL5rR-0001fj-CB
 for qemu-devel@nongnu.org; Fri, 30 May 2025 15:57:51 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so2489647a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748635067; x=1749239867; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=i/ErOmswlJOoVR4M1ZO3vfVuY1CrD+LRjJ2SE66WtCc=;
 b=VWD8LgrLvOoSSBYkKBM2r4A6dLNEXPhq48CXPCWjjQ8kyYUq8XeyJNQ22kgPcProXI
 +86s3kXez/bmG5QoOzIHia1usvvBhQSamzwtfQLwyjwbFX3cMHrNsvyddI2w1aTVxNPi
 5pO8wujGqeFGX///6L/X+V6UYcsHMB8YXu8p5eG3y//WJz0PLtZ3M/LcaybURFk8HSiR
 QhH05uzSR8E8ASZz7zHwl6Y8WplS5QJKNjJ2/SmezkH4Za69pr49XImZtrDcfecVM6Eg
 pJE9kgaRw07R7lb7kQ1AdJmXzQD7dUKEU5krQpef3U9/EKgmkYOQp50knDltz1qNrGP3
 qoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748635067; x=1749239867;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i/ErOmswlJOoVR4M1ZO3vfVuY1CrD+LRjJ2SE66WtCc=;
 b=i0E2Gcio2Rn07EgoGAw7fCB2gv75hxWUOIdr6p5egKJN24ZjSb/LiMehuJORyfuAx4
 +DdPluEtRDf8yybO7bqqC6/8SJqBVCUxrIhQb5T9iRhFLYbD2OC5O7eiQcSt295UGukU
 wY288iC58e+R7pmRI4QnMzcGS7b9hMy+xT/kva4XRqKPJgjxmJfywY96N0wHWyRtMizm
 ekMix8xH19QU7GYsxY1TxMFql4HXODRG2Wzy0rCNIqo19y2nA1bZE9VZkD/P80MqVKjY
 OcmuyxX6ej2cJn+nyxYsg3xOTp79xPZlSjd876jn3FJEHUhhTTOxxvg4JYMorhYCC4Dm
 VefQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVefT19Fe/nQcV5kgDLxjobsZVEiKxXuKIj8wWOslMmswTLq2BCOkfBDJzFDmLSVtTNCtg4OQAxhHLA@nongnu.org
X-Gm-Message-State: AOJu0YxmbNbDf3vVdPBujYq1BbZcefbxufW50mXXbE4IYCSeoDeSSZZs
 yVk1F9QzUbf+IaKpbGpHLatjKLo5kFtwxZc8Q9nx/WlBMBhX1m2VMWhA40qqZg==
X-Gm-Gg: ASbGnct+G33JEorp+cJcjsz74MXM/mX4/qzGmmsmUd4b6j0UugEeB4ATU6SHlP8zbVB
 W+opJlcE303aN8GY4woVMzHQ0ZToG447sj0zE6W/oPrU1K7wOFzo61uGFcs+SF70GIP+eQVu5xe
 7yFEaeThUDWD+ZSp+BKzmLfLj/k59BBepZHnglQiNvjygid8x5Xz9RGFgv0PApwb3q81AwSMQ7c
 wT5w9ov1IUJ5KUreab4Bts7Th/V4DSVEAIKuCnd6IS/CjFfwepQnKpi8EeY/Guf+H09rrQoIej+
 igKqNGPUW30X2zCHza3bXV3fLfwGFy5C9gVYV+HFJwHJgu8J629nBwBxsV/9B3WCkXcwrTD35AH
 Ygw==
X-Google-Smtp-Source: AGHT+IFT8s+hVa62EhYMJFJNvdliv5us6aWbRl3wyQxz6lZ8/5/4ozmHl3yjNVl32O3S9+dAsSjyVA==
X-Received: by 2002:a17:90b:1dce:b0:312:26d9:d5a0 with SMTP id
 98e67ed59e1d1-312413f60famr6676212a91.3.1748635056663; 
 Fri, 30 May 2025 12:57:36 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b2eceb02662sm1909385a12.5.2025.05.30.12.57.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 12:57:36 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 30 May 2025 19:57:34 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Anisa Su <anisa.su887@gmail.com>, Fan Ni <nifan.cxl@gmail.com>,
 qemu-devel@nongnu.org, dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aDoNrrGFWtTMsyEw@deb-101020-bm01.eng.stellus.in>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
 <aCyhv8Qz1LUpJKd3@lg>
 <aCy8-vMEYsFaOiWC@deb-101020-bm01.eng.stellus.in>
 <20250530144335.000064f3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530144335.000064f3@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=anisa.su887@gmail.com; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, May 30, 2025 at 02:43:35PM +0100, Jonathan Cameron wrote:
> On Tue, 20 May 2025 17:33:46 +0000
> Anisa Su <anisa.su887@gmail.com> wrote:
> 
> > On Tue, May 20, 2025 at 08:37:35AM -0700, Fan Ni wrote:
> > > On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:  
> > > > From: Anisa Su <anisa.su@samsung.com>
> > > > 
> > > > In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> > > > for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> > > > certain command sets are bound with the correct MCTP binding.
> > > > 
> > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
> > > >  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++  
> > > 
> > > Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
> > > creating a new file. cxl_mailbox.h only has some macros.
> > > 
> > > Fan
> > >   
> > I had some discussion with Jonathan in the v1 thread about this. We
> > agreed it is fine to use mailbox.h because it only has a few macros in it,
> > but in case more things get added to it later, I made a separate file.
> > Then no need to re-organize later.
> > > 
> 
> We can always move them in future if it turns out cxl_mailbox.h is
> not a good home.
> 
> Also, note that the include file added in this patch has no descriptive
> comments or ifndef magic which would have wanted to be there.
> 
> Jonathan
> 
Ah ok~ I'll have it in cxl_mailbox.h for v3 then.

Thanks,
Anisa
> > >   
> > > >  2 files changed, 66 insertions(+), 66 deletions(-)
> > > >  create mode 100644 include/hw/cxl/cxl_opcodes.h
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index a02d130926..ed3294530f 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -23,6 +23,7 @@
> > > >  #include "qemu/uuid.h"
> > > >  #include "system/hostmem.h"
> > > >  #include "qemu/range.h"
> > > > +#include "hw/cxl/cxl_opcodes.h"
> > > >  
> > > >  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> > > >  #define CXL_DC_EVENT_LOG_SIZE 8
> > > > @@ -36,7 +37,7 @@
> > > >  
> > > >  /*
> > > >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > > > - *  1. Add the command set and cmd to the enum.
> > > > + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
> > > >   *     FOO    = 0x7f,
> > > >   *          #define BAR 0
> > > >   *  2. Implement the handler
> > > > @@ -59,71 +60,6 @@
> > > >   *  a register interface that already deals with it.
> > > >   */
> > > >  
> > > > -enum {
> > > > -    INFOSTAT    = 0x00,
> > > > -        #define IS_IDENTIFY   0x1
> > > > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > > > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > > > -    EVENTS      = 0x01,
> > > > -        #define GET_RECORDS   0x0
> > > > -        #define CLEAR_RECORDS   0x1
> > > > -        #define GET_INTERRUPT_POLICY   0x2
> > > > -        #define SET_INTERRUPT_POLICY   0x3
> > > > -    FIRMWARE_UPDATE = 0x02,
> > > > -        #define GET_INFO      0x0
> > > > -        #define TRANSFER      0x1
> > > > -        #define ACTIVATE      0x2
> > > > -    TIMESTAMP   = 0x03,
> > > > -        #define GET           0x0
> > > > -        #define SET           0x1
> > > > -    LOGS        = 0x04,
> > > > -        #define GET_SUPPORTED 0x0
> > > > -        #define GET_LOG       0x1
> > > > -        #define GET_LOG_CAPABILITIES   0x2
> > > > -        #define CLEAR_LOG     0x3
> > > > -        #define POPULATE_LOG  0x4
> > > > -    FEATURES    = 0x05,
> > > > -        #define GET_SUPPORTED 0x0
> > > > -        #define GET_FEATURE   0x1
> > > > -        #define SET_FEATURE   0x2
> > > > -    IDENTIFY    = 0x40,
> > > > -        #define MEMORY_DEVICE 0x0
> > > > -    CCLS        = 0x41,
> > > > -        #define GET_PARTITION_INFO     0x0
> > > > -        #define GET_LSA       0x2
> > > > -        #define SET_LSA       0x3
> > > > -    HEALTH_INFO_ALERTS = 0x42,
> > > > -        #define GET_ALERT_CONFIG 0x1
> > > > -        #define SET_ALERT_CONFIG 0x2
> > > > -    SANITIZE    = 0x44,
> > > > -        #define OVERWRITE     0x0
> > > > -        #define SECURE_ERASE  0x1
> > > > -        #define MEDIA_OPERATIONS 0x2
> > > > -    PERSISTENT_MEM = 0x45,
> > > > -        #define GET_SECURITY_STATE     0x0
> > > > -    MEDIA_AND_POISON = 0x43,
> > > > -        #define GET_POISON_LIST        0x0
> > > > -        #define INJECT_POISON          0x1
> > > > -        #define CLEAR_POISON           0x2
> > > > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > > -        #define SCAN_MEDIA             0x4
> > > > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > > -    DCD_CONFIG  = 0x48,
> > > > -        #define GET_DC_CONFIG          0x0
> > > > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > > > -        #define ADD_DYN_CAP_RSP        0x2
> > > > -        #define RELEASE_DYN_CAP        0x3
> > > > -    PHYSICAL_SWITCH = 0x51,
> > > > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > > > -    TUNNEL = 0x53,
> > > > -        #define MANAGEMENT_COMMAND     0x0
> > > > -    MHD = 0x55,
> > > > -        #define GET_MHD_INFO 0x0
> > > > -};
> > > > -
> > > >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > > >  typedef struct CXLCCIMessage {
> > > >      uint8_t category;
> > > > diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> > > > new file mode 100644
> > > > index 0000000000..26d3a99e8a
> > > > --- /dev/null
> > > > +++ b/include/hw/cxl/cxl_opcodes.h
> > > > @@ -0,0 +1,64 @@
> > > > +enum {
> > > > +    INFOSTAT    = 0x00,
> > > > +        #define IS_IDENTIFY   0x1
> > > > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > > > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > > > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > > > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > > > +    EVENTS      = 0x01,
> > > > +        #define GET_RECORDS   0x0
> > > > +        #define CLEAR_RECORDS   0x1
> > > > +        #define GET_INTERRUPT_POLICY   0x2
> > > > +        #define SET_INTERRUPT_POLICY   0x3
> > > > +    FIRMWARE_UPDATE = 0x02,
> > > > +        #define GET_INFO      0x0
> > > > +        #define TRANSFER      0x1
> > > > +        #define ACTIVATE      0x2
> > > > +    TIMESTAMP   = 0x03,
> > > > +        #define GET           0x0
> > > > +        #define SET           0x1
> > > > +    LOGS        = 0x04,
> > > > +        #define GET_SUPPORTED 0x0
> > > > +        #define GET_LOG       0x1
> > > > +        #define GET_LOG_CAPABILITIES   0x2
> > > > +        #define CLEAR_LOG     0x3
> > > > +        #define POPULATE_LOG  0x4
> > > > +    FEATURES    = 0x05,
> > > > +        #define GET_SUPPORTED 0x0
> > > > +        #define GET_FEATURE   0x1
> > > > +        #define SET_FEATURE   0x2
> > > > +    IDENTIFY    = 0x40,
> > > > +        #define MEMORY_DEVICE 0x0
> > > > +    CCLS        = 0x41,
> > > > +        #define GET_PARTITION_INFO     0x0
> > > > +        #define GET_LSA       0x2
> > > > +        #define SET_LSA       0x3
> > > > +    HEALTH_INFO_ALERTS = 0x42,
> > > > +        #define GET_ALERT_CONFIG 0x1
> > > > +        #define SET_ALERT_CONFIG 0x2
> > > > +    SANITIZE    = 0x44,
> > > > +        #define OVERWRITE     0x0
> > > > +        #define SECURE_ERASE  0x1
> > > > +        #define MEDIA_OPERATIONS 0x2
> > > > +    PERSISTENT_MEM = 0x45,
> > > > +        #define GET_SECURITY_STATE     0x0
> > > > +    MEDIA_AND_POISON = 0x43,
> > > > +        #define GET_POISON_LIST        0x0
> > > > +        #define INJECT_POISON          0x1
> > > > +        #define CLEAR_POISON           0x2
> > > > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > > > +        #define SCAN_MEDIA             0x4
> > > > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > > > +    DCD_CONFIG  = 0x48,
> > > > +        #define GET_DC_CONFIG          0x0
> > > > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > > > +        #define ADD_DYN_CAP_RSP        0x2
> > > > +        #define RELEASE_DYN_CAP        0x3
> > > > +    PHYSICAL_SWITCH = 0x51,
> > > > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > > > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > > > +    TUNNEL = 0x53,
> > > > +        #define MANAGEMENT_COMMAND     0x0
> > > > +    MHD = 0x55,
> > > > +        #define GET_MHD_INFO 0x0
> > > > +};
> > > > -- 
> > > > 2.47.2
> > > >   
> > > 
> > > -- 
> > > Fan Ni  
> 

