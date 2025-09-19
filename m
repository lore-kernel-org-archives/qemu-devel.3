Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15337CAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 20:48:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzi1G-0002ek-E9; Fri, 19 Sep 2025 16:47:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzi1D-0002ds-WF
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:47:48 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uzi1B-0004eh-SI
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 16:47:47 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b54a2ab01ffso1804497a12.2
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 13:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758314863; x=1758919663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9hQ5F1av6CyerZ7KwU/Lcf5Fr+ZAf/betmK+nhjTU4=;
 b=SCcoV/j+KgIT8mocPO64XXF3sU14bWe8iXcqO52LMt3BTEVBdff6AKRhD8ABEDML+3
 7/O/UMRpngVKHpXsCHaLYJu3q7pB+OYnkUbxxV7mx/ORY2XQlMrQwJQeqgHXfFcXfeMs
 UbVdaKSPn/6g/I+gzUpum7HPi0s+lZb5HqsmUYSlk/0XVmRGvNqTA387VQC1Yi/KYkOj
 7jtTK2OadbRmnoGvFU78PNGD0eGB248HWkHWh2A6gHVI8kQloDJoKo1Kc/tknhLTEimu
 Cpq98OZUAnapyLNlP4NyP6VN61Aj6rwHQv+eD7l7BG/DL5qgJGkTmjFsjKQM2rTzMVp9
 74Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758314863; x=1758919663;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e9hQ5F1av6CyerZ7KwU/Lcf5Fr+ZAf/betmK+nhjTU4=;
 b=G9sDIiVoW0GM69OEzIlmjOfuIp2ehIWOrwDdK8k2Ch6GpaK6K3/4GcKkQGvHuO0ro8
 yGw76nGhZpLDrLIrSHlxl7+KvIWF6CvZl+ae/mOPTAjjJEjtnm40hfONXW4MUQjt7ZXr
 6VNV/r1jjyh/I2WIPqjC65xujFdXc5iMad1lT1SjM5dKh7spPqQQw6tQFIaUUtJ87rBv
 95/0TRYP3QsZxA/yg5t/uvAcW0BN4fOdssYSGmI4X5JlvZMcXPNDa+5rvoJs6QvU2Yj9
 nEGWtI4JWVaF7BgEwaXjopGiJK+aQSP2uJbovMOpqpIR7BEblD90RiZuTWopeoV3KF9X
 tm1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCURZ3+AA4hCFAYvkS8M9wDO/cDVX2VB0YR2kMlzo37RAy4AJ+w+cweq3zoWat9ZyALZFn73NQnIheHO@nongnu.org
X-Gm-Message-State: AOJu0YwJkAlyQ1pWY/PJdIrpgG5reMwvpHHLy1tenrz3ETHzja5UjSRn
 JHQ1Gi008MP3nldNvDKLSLY9IXOhq6NlEeVNIa53b7p3qxknXB3gz+T11PVpe47vnKgUnoCSmjo
 KjE+c
X-Gm-Gg: ASbGncubYgOzmo0Xomd9YGsCBiKElADWwgqzQdtLmDDzwK5eZR2ljyZ1lt+9BQr2Ht8
 /MC1rZQaTgVoLnCqgand6nwggYLt9akuD7HPduDhUWTHTC9/Ivw0dbvOBzfSD8ulqod+GnsMUmO
 EWAaDeH4TyqoWVbYw/YO9/+JZAk+YQM0O8CfSglE5MAVQBxZG3tbEVHqmuSCOMS193ovxr/D2aI
 7T3tedmfVKmIxc3h+2iGngL1FgVVbmn10o884FcO2AcimydvDessgFRcFB7ea0LjrAk2L3+9DWP
 FFrbvrZWAPOhZHlg5jtLGxmq2dfS9wfPSVO8qj9pDADRWurF8IYvymILrx8bwW+0K6ONpYJQ7xo
 aqSZGOEmWoZzAwrxvLcabB35SBsL68LH0kxvyp6CZHsQWTN8=
X-Google-Smtp-Source: AGHT+IGD/xm+CBhWSbHWbbEWgIGZUQ58s8NM4pmzQ8yqDr9JJb3yhCK3VB+/2B1OmnaNBkp0Gbk1Iw==
X-Received: by 2002:a17:902:fc46:b0:248:e3fb:4dc8 with SMTP id
 d9443c01a7336-269ba534defmr58028145ad.39.1758314863295; 
 Fri, 19 Sep 2025 13:47:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-26980357043sm62061345ad.138.2025.09.19.13.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 13:47:42 -0700 (PDT)
Message-ID: <e2afe1c4-4a47-4e88-9d4b-c2d0fac15add@linaro.org>
Date: Fri, 19 Sep 2025 13:47:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/16] Treewide I/O handle cleanup
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
References: <20250919115017.1536203-1-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

On 9/19/25 04:50, Daniel P. Berrangé wrote:
> The following changes since commit e7c1e8043a69c5a8efa39d4f9d111f7c72c076e6:
> 
>    Merge tag 'pull-loongarch-20250918' ofhttps://github.com/gaosong715/qemu into staging (2025-09-18 07:08:08 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/berrange/qemu tags/misc-fixes-pull-request
> 
> for you to fetch changes up to 34523df31962401871ff091a9d0993ac87a9848a:
> 
>    util/vhost-user-server: vu_message_read(): improve error handling (2025-09-19 12:46:07 +0100)
> 
> ----------------------------------------------------------------
>   * Update security triage contact address
>   * Switch to common helper for changing blocking flag
>     across socket and non-socket FDs
>   * Check and honour failures to the blocking flag on FDs
>   * Don't touch blocking flags on FDs received during migration
>   * Remove redundant O_NONBLOCK/O_CLOEXEC handling in chardev


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

