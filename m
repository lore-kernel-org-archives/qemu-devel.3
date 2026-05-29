Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8463BCD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 06:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSquH-0007Zj-9t; Fri, 29 May 2026 02:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSquB-0007UA-L3
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:41:15 -0400
Received: from jupiter.guys.cyano.uk ([45.63.120.176])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cyan@cyano.uk>) id 1wSqu8-0001qQ-KN
 for qemu-devel@nongnu.org; Fri, 29 May 2026 02:41:14 -0400
Message-ID: <e2e3f06b-e7b6-4ea1-ab4e-06b0f38438e6@cyano.uk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyano.uk; s=dkim;
 t=1780036861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ziQsKgToYXlNnX5biXLHq1B9454ruJ5nsJ2a09YkIBo=;
 b=eP79rLxI/iWOPEndaAnulv4CJMwxuI8Le1HckuT/OXBoTDTNir0hbYmSyhrrOks+0IRW4d
 ANVSFWAybtQSVfggfJlToT8bCvPpi7y23lZ4d3YYVBTzSLdWZ30euneIs7SRR1/8FDjiRK
 pWghJ5ZPDWbPOV1mygOoFyyPJ4uuELsjl1OCDm/LlGjn+XR3PmXzo2fTsrKYbBijqCuMSO
 Z4dL8T2PpfWjm486o7WmG5t2/mh3TDNtR/Hsl6N5Nayro5PpmYx/ChVGTii7TCa/Bbf+oQ
 whj2KoFWgkJVhbqJTlBrKClo7eLzaRewnsgiOPXO0T2lZw/BZPNMEBK+csASyw==
Authentication-Results: jupiter.guys.cyano.uk;
 auth=pass smtp.mailfrom=cyan@cyano.uk
Date: Fri, 29 May 2026 14:40:54 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] linux-user: implement fsmount(2) series of syscalls
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Mingcong Bai <jeffbai@aosc.io>
References: <cover.1779876076.git.cyan@cyano.uk>
 <cec3a2d387f87cd9a8b03d864c7accd804d698ce.1779876076.git.cyan@cyano.uk>
 <77a000e4-04dd-4abe-95ac-0c411e8e0575@oss.qualcomm.com>
Content-Language: en-US
From: Xinhui Yang <cyan@cyano.uk>
In-Reply-To: <77a000e4-04dd-4abe-95ac-0c411e8e0575@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Received-SPF: pass client-ip=45.63.120.176; envelope-from=cyan@cyano.uk;
 helo=jupiter.guys.cyano.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

在 2026/5/29 03:07, Pierrick Bouvier 写道:
> On 5/27/2026 3:11 AM, Xinhui Yang wrote:
>> This series of syscalls replaces the old mount(2) syscall with a series
>> of syscalls that operates around a filesystem context. This series of
>> syscalls is available since Linux 5.2 and glibc 2.36+.
>>
>> Their users include systemd since v259 and libmount from util-linux, and
>> possibly other widely used projects.
>>
>> Preliminary checks are implemented to ensure the validity of the
>> interface.
>>
>> Signed-off-by: Xinhui Yang <cyan@cyano.uk>
>> ---
>>   linux-user/syscall.c | 81 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 81 insertions(+)
>>
>> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
>> index 7d7a7b489c..2ff80f4dfa 100644
>> --- a/linux-user/syscall.c
>> +++ b/linux-user/syscall.c
>> @@ -14412,6 +14412,87 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>>           return do_map_shadow_stack(cpu_env, arg1, arg2, arg3);
>>   #endif
>>   
>> +#if defined(TARGET_NR_fsopen)
>> +    case TARGET_NR_fsopen:
>> +        {
>> +            p = lock_user_string(arg1);
>> +            if (!p) {
>> +                return -TARGET_EFAULT;
>> +            }
>> +            ret = get_errno(fsopen(p, arg2));
>> +            unlock_user(p, arg1, 0);
>> +        }
>> +        return ret;
>> +    case TARGET_NR_fsconfig:
>> +        {
>> +            /*
>> +             * fsconfig(int, int, char *, void *, int)
>> +             * NOTE: p4 is nullable and its type might not be a string.
>> +             */
>> +            void *p3, *p4;
>> +            int cmd = (int) arg2;
>> +            switch (cmd) {
>> +            case FSCONFIG_SET_BINARY:
>> +            case FSCONFIG_SET_STRING:
>> +            case FSCONFIG_SET_PATH:
>> +            case FSCONFIG_SET_PATH_EMPTY:
>> +                p3 = lock_user_string(arg3);
>> +                if (cmd != FSCONFIG_SET_BINARY) {
>> +                    /* key and value must be strings. */
>> +                    p4 = lock_user_string(arg4);
>> +                } else {
>> +                    /* Otherise the value must be a raw buffer. */
>> +                    p4 = lock_user(VERIFY_READ, arg4, arg5, 1);
>> +                }
>> +                if (!p3 || !p4) {
>> +                    return -TARGET_EFAULT;
>> +                }
> 
> Might leave with locked p3 is p4 fails.
> You can add another early return just after p3 and unlock p3 in this if.
> 

Thanks! Sending v3.

>> +                ret = get_errno(fsconfig(arg1, arg2, p3, p4, arg5));
>> +                unlock_user(p3, arg3, 0);
>> +                unlock_user(p4, arg4, 0);
>> +                break;
>> +
>> +            case FSCONFIG_SET_FLAG:
>> +            case FSCONFIG_SET_FD:
>> +                /* value must be NULL. */
>> +                p3 = lock_user_string(arg3);
>> +                if (!p3 || arg4) {
>> +                    return -TARGET_EFAULT;
>> +                }
>> +                ret = get_errno(fsconfig(arg1, arg2, p3, NULL, arg5));
> 
> Similar to above (if arg4) { unlock... }
> 
>> +                unlock_user(p3, arg3, 0);
>> +                break;
>> +            case FSCONFIG_CMD_CREATE:
>> +            case FSCONFIG_CMD_RECONFIGURE:
>> +#ifdef FSCONFIG_CMD_CREATE_EXCL
>> +            /*
>> +             * FSCONFIG_CMD_CREATE_EXCL is only available since Linux
>> +             * 6.6. Guarding it to allow building with pre-6.6 headers.
>> +             */
>> +            case FSCONFIG_CMD_CREATE_EXCL:
>> +#endif
>> +                /* key and value must be NULL, aux must be 0. */
>> +                if (arg3 || arg4 || arg5) {
>> +                    return -TARGET_EFAULT;
>> +                }
>> +                ret = get_errno(fsconfig(arg1, arg2, NULL, NULL, 0));
>> +                break;
>> +            default:
>> +                return -TARGET_EFAULT;
>> +            }
>> +        }
>> +        return ret;
>> +    case TARGET_NR_fsmount:
>> +        ret = get_errno(fsmount(arg1, arg2, arg3));
>> +        return ret;
>> +    case TARGET_NR_fspick:
>> +        {
>> +            p = lock_user_string(arg2);
>> +            ret = get_errno(fspick(arg1, p, arg3));
>> +            unlock_user(p, arg2, 0);
>> +        }
>> +        return ret;
>> +#endif
>>       default:
>>           qemu_log_mask(LOG_UNIMP, "Unsupported syscall: %d\n", num);
>>           return -TARGET_ENOSYS;
> 

Xinhui

