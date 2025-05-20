Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2843C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 15:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHP2K-00042E-Qd; Tue, 20 May 2025 11:37:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHP2I-00041c-GJ
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:37:46 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1uHP2F-0000N2-VE
 for qemu-devel@nongnu.org; Tue, 20 May 2025 11:37:46 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-742c3d06de3so3292479b3a.0
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747755461; x=1748360261; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QfUgbG7wlz+ybzD3R782KbS9QXsdGRcz+HFsWFmMcKY=;
 b=QFzqFy7v5zGJXWSlQC411rN91ndUmpIFSITLx93+Ty6tiSi1TBlY9bqBEpW9AQqKkt
 laEEXuNZITX7KdA846skgGyX7jB0wIvl9R5TgJKuogzbyIRDYhOv1j/Mj9EtjUsUjvmZ
 vW2ZyOXcqzvb1y4HatvAAd99pb1PhD82ddTKBiA4D6U2UWYrmftoPsK6QP3sbcEoFXJH
 VgLJACecQ0OQmIRpxNqRYIKpCeYyNdcUqTexrDXzdUW/CTOpv4WB9kF6+zP7yn2rR1d5
 ObZFrpCwLxgeeEwqg7n8X2OCGgm+T+DA3JIf00yvvED5sA+nlu4Yem/DhakHZODX+yay
 iLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747755461; x=1748360261;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QfUgbG7wlz+ybzD3R782KbS9QXsdGRcz+HFsWFmMcKY=;
 b=EaUcdoxpVVqPv1JEoCyBfvJEleG+uBhecKZppj37iNjZK4HMOx/K8h04wa9Fjf/oWE
 DPWId/sfPs4ALgH2gZkIqywLiKnvRtY0JBWcEzeCjhWU9OkHVdlTvwa+cHXN8kqss22I
 5b/MwkE0JhqH0N00D34HVAqJ2CEdxdJgcpv+OtiH+Ow8Aa84GqnJ9rGnrCrAooUxhVwV
 BSRM7yGMPcqNsrvCbeDQdEdzGmrsLhKWUjWre3KT+B0RL7io1xwM0acvSvgOqz+5NX6+
 bJ1T0kGU98b3+yYuPWK+5omUB65VqAfh8tPVlGn9Ji11HmXE1T3u+qwhKHCE8iEYoe9G
 wRzQ==
X-Gm-Message-State: AOJu0Yy8A72Qc6SZeFGzi9s6R0bMOQKXYTf9k4ET64qR4DIGZFD08jA1
 zYXGZvLgfhb+3EX9pPh/r6LI/FviH9TRlFw7f9bnou4DqLibleXZr5R5
X-Gm-Gg: ASbGncvtaS/JrVwI1dNVz1O/oHV7nhXLTTbU50A493zD6UR19zH76XhImljeENDeST+
 DRpd75QbiqfDlbcBmnQGenqYm7wou5lfC+cOBi7C43yYap2QhBSOoBAB0z44X+4IJCdfkcCe5yV
 p9uBS+QCAAc5tpbhZ6xaNm5wAs0JSYdDLcekI8N/qMx9IyVWJqwmDLYQtHWMtTdHEgBdglsb2iR
 9QRXpTp1FJzOD1caYEEu033geEEoMEJss5aOebliQ/SM3PiaWD64bOMLSbViTI5ErHRW/pk5rYf
 K2+a8J/CUyxsz9XJ/mw1Z1+UkFgqTFK1IlKz4bGblbvGl3MdDBkD
X-Google-Smtp-Source: AGHT+IEwSkvU591UJhbKnDRmu73swl+LkaJvyIbpoNTzQIdAkiru/cpM8OObscQjElXrRH2kNDBEOQ==
X-Received: by 2002:a05:6a00:3492:b0:742:9bd3:cd1f with SMTP id
 d2e1a72fcca58-742acd728eamr21638969b3a.23.1747755461288; 
 Tue, 20 May 2025 08:37:41 -0700 (PDT)
Received: from lg ([2601:646:8f03:9fee:2c89:c0cf:1cbd:96d3])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a9739906sm8071440b3a.80.2025.05.20.08.37.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 May 2025 08:37:40 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Tue, 20 May 2025 08:37:35 -0700
To: anisa.su887@gmail.com
Cc: qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org,
 Anisa Su <anisa.su@samsung.com>
Subject: Re: [PATCH v2 01/10] cxl-mailbox-utils: Move opcodes enum to new
 header file
Message-ID: <aCyhv8Qz1LUpJKd3@lg>
References: <20250508001754.122180-1-anisa.su887@gmail.com>
 <20250508001754.122180-2-anisa.su887@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508001754.122180-2-anisa.su887@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu, May 08, 2025 at 12:00:57AM +0000, anisa.su887@gmail.com wrote:
> From: Anisa Su <anisa.su@samsung.com>
> 
> In preparation for the next patch, move opcodes enum to new cxl_opcodes.h file
> for visibility from mailbox-utils.c and i2c_mctp_cxl.c, which checks that
> certain command sets are bound with the correct MCTP binding.
> 
> Signed-off-by: Anisa Su <anisa.su@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c   | 68 ++----------------------------------
>  include/hw/cxl/cxl_opcodes.h | 64 +++++++++++++++++++++++++++++++++

Should we put the opcodes into include/hw/cxl/cxl_mailbox.h instead of
creating a new file. cxl_mailbox.h only has some macros.

Fan



>  2 files changed, 66 insertions(+), 66 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_opcodes.h
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index a02d130926..ed3294530f 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -23,6 +23,7 @@
>  #include "qemu/uuid.h"
>  #include "system/hostmem.h"
>  #include "qemu/range.h"
> +#include "hw/cxl/cxl_opcodes.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  #define CXL_DC_EVENT_LOG_SIZE 8
> @@ -36,7 +37,7 @@
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> - *  1. Add the command set and cmd to the enum.
> + *  1. Add the command set and cmd to the enum in cxl_opcodes.h.
>   *     FOO    = 0x7f,
>   *          #define BAR 0
>   *  2. Implement the handler
> @@ -59,71 +60,6 @@
>   *  a register interface that already deals with it.
>   */
>  
> -enum {
> -    INFOSTAT    = 0x00,
> -        #define IS_IDENTIFY   0x1
> -        #define BACKGROUND_OPERATION_STATUS    0x2
> -        #define GET_RESPONSE_MSG_LIMIT         0x3
> -        #define SET_RESPONSE_MSG_LIMIT         0x4
> -        #define BACKGROUND_OPERATION_ABORT     0x5
> -    EVENTS      = 0x01,
> -        #define GET_RECORDS   0x0
> -        #define CLEAR_RECORDS   0x1
> -        #define GET_INTERRUPT_POLICY   0x2
> -        #define SET_INTERRUPT_POLICY   0x3
> -    FIRMWARE_UPDATE = 0x02,
> -        #define GET_INFO      0x0
> -        #define TRANSFER      0x1
> -        #define ACTIVATE      0x2
> -    TIMESTAMP   = 0x03,
> -        #define GET           0x0
> -        #define SET           0x1
> -    LOGS        = 0x04,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_LOG       0x1
> -        #define GET_LOG_CAPABILITIES   0x2
> -        #define CLEAR_LOG     0x3
> -        #define POPULATE_LOG  0x4
> -    FEATURES    = 0x05,
> -        #define GET_SUPPORTED 0x0
> -        #define GET_FEATURE   0x1
> -        #define SET_FEATURE   0x2
> -    IDENTIFY    = 0x40,
> -        #define MEMORY_DEVICE 0x0
> -    CCLS        = 0x41,
> -        #define GET_PARTITION_INFO     0x0
> -        #define GET_LSA       0x2
> -        #define SET_LSA       0x3
> -    HEALTH_INFO_ALERTS = 0x42,
> -        #define GET_ALERT_CONFIG 0x1
> -        #define SET_ALERT_CONFIG 0x2
> -    SANITIZE    = 0x44,
> -        #define OVERWRITE     0x0
> -        #define SECURE_ERASE  0x1
> -        #define MEDIA_OPERATIONS 0x2
> -    PERSISTENT_MEM = 0x45,
> -        #define GET_SECURITY_STATE     0x0
> -    MEDIA_AND_POISON = 0x43,
> -        #define GET_POISON_LIST        0x0
> -        #define INJECT_POISON          0x1
> -        #define CLEAR_POISON           0x2
> -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> -        #define SCAN_MEDIA             0x4
> -        #define GET_SCAN_MEDIA_RESULTS 0x5
> -    DCD_CONFIG  = 0x48,
> -        #define GET_DC_CONFIG          0x0
> -        #define GET_DYN_CAP_EXT_LIST   0x1
> -        #define ADD_DYN_CAP_RSP        0x2
> -        #define RELEASE_DYN_CAP        0x3
> -    PHYSICAL_SWITCH = 0x51,
> -        #define IDENTIFY_SWITCH_DEVICE      0x0
> -        #define GET_PHYSICAL_PORT_STATE     0x1
> -    TUNNEL = 0x53,
> -        #define MANAGEMENT_COMMAND     0x0
> -    MHD = 0x55,
> -        #define GET_MHD_INFO 0x0
> -};
> -
>  /* CCI Message Format CXL r3.1 Figure 7-19 */
>  typedef struct CXLCCIMessage {
>      uint8_t category;
> diff --git a/include/hw/cxl/cxl_opcodes.h b/include/hw/cxl/cxl_opcodes.h
> new file mode 100644
> index 0000000000..26d3a99e8a
> --- /dev/null
> +++ b/include/hw/cxl/cxl_opcodes.h
> @@ -0,0 +1,64 @@
> +enum {
> +    INFOSTAT    = 0x00,
> +        #define IS_IDENTIFY   0x1
> +        #define BACKGROUND_OPERATION_STATUS    0x2
> +        #define GET_RESPONSE_MSG_LIMIT         0x3
> +        #define SET_RESPONSE_MSG_LIMIT         0x4
> +        #define BACKGROUND_OPERATION_ABORT     0x5
> +    EVENTS      = 0x01,
> +        #define GET_RECORDS   0x0
> +        #define CLEAR_RECORDS   0x1
> +        #define GET_INTERRUPT_POLICY   0x2
> +        #define SET_INTERRUPT_POLICY   0x3
> +    FIRMWARE_UPDATE = 0x02,
> +        #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
> +    TIMESTAMP   = 0x03,
> +        #define GET           0x0
> +        #define SET           0x1
> +    LOGS        = 0x04,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_LOG       0x1
> +        #define GET_LOG_CAPABILITIES   0x2
> +        #define CLEAR_LOG     0x3
> +        #define POPULATE_LOG  0x4
> +    FEATURES    = 0x05,
> +        #define GET_SUPPORTED 0x0
> +        #define GET_FEATURE   0x1
> +        #define SET_FEATURE   0x2
> +    IDENTIFY    = 0x40,
> +        #define MEMORY_DEVICE 0x0
> +    CCLS        = 0x41,
> +        #define GET_PARTITION_INFO     0x0
> +        #define GET_LSA       0x2
> +        #define SET_LSA       0x3
> +    HEALTH_INFO_ALERTS = 0x42,
> +        #define GET_ALERT_CONFIG 0x1
> +        #define SET_ALERT_CONFIG 0x2
> +    SANITIZE    = 0x44,
> +        #define OVERWRITE     0x0
> +        #define SECURE_ERASE  0x1
> +        #define MEDIA_OPERATIONS 0x2
> +    PERSISTENT_MEM = 0x45,
> +        #define GET_SECURITY_STATE     0x0
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
> +        #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
> +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> +        #define SCAN_MEDIA             0x4
> +        #define GET_SCAN_MEDIA_RESULTS 0x5
> +    DCD_CONFIG  = 0x48,
> +        #define GET_DC_CONFIG          0x0
> +        #define GET_DYN_CAP_EXT_LIST   0x1
> +        #define ADD_DYN_CAP_RSP        0x2
> +        #define RELEASE_DYN_CAP        0x3
> +    PHYSICAL_SWITCH = 0x51,
> +        #define IDENTIFY_SWITCH_DEVICE      0x0
> +        #define GET_PHYSICAL_PORT_STATE     0x1
> +    TUNNEL = 0x53,
> +        #define MANAGEMENT_COMMAND     0x0
> +    MHD = 0x55,
> +        #define GET_MHD_INFO 0x0
> +};
> -- 
> 2.47.2
> 

-- 
Fan Ni

