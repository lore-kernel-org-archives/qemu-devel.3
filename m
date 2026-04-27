Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D0B2FF8868
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 18:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHQrj-00027Z-M1; Mon, 27 Apr 2026 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQrh-00027B-Dc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:39:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wHQre-0008Mt-CT
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 14:39:29 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RCp9Vt2382917
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:39:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 g/KHcZMmL5w/SgxdbTJ3+hx9/L0qu6MGRdeFCW9qtfk=; b=NYkX+t0UZruzFLfY
 d0YALMFBdlZAmRF3eKPOaTjz9xM1fk1WOkfmeUQA6gMhByaqT78m8I28GvUxlLGg
 2JLQ6dla1T1cc5l5BMyrS0Kw/J9yGJ6gxRox/1dLvmzVkjCkzVLnc0LIm1vE1chk
 lquL4V3QaAdLHbNVp/AGy7pjtigUk7VIC+39QedpaL0DYsSaxTjOnO1VdSzMV3kd
 WUjfXiq742ndUUD9RX5DwJwQOpK+iSyz5LK1nbURELfcifjALAXlGwbsk5ZRUsHr
 bUmRG2ZA00CO0eSkypVXTVGX2T/8WGz1Rg9vv+v/8hi/fsWV3APXrCsJuK+Dp5zG
 qHpUxw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt85xsbuu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 18:39:22 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2d889997495so28097709eec.0
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 11:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777315162; x=1777919962; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g/KHcZMmL5w/SgxdbTJ3+hx9/L0qu6MGRdeFCW9qtfk=;
 b=NzLblnq0k9WjvUzg1UDoDqnFtgK32/1rPFssNYlgHgTxAh0YQkLKiO+5gqnnhHjVUZ
 aOZTo69+29Qt/RGu2DovhGUADXRx8o3wfXJY4N09Qfoy/Zg96ndN3MMLMN5hm/CXu8a4
 22/IVk0P5xpEOE0fHJ23VZk7gbN2j3IX9RVwqZN+EIR0CkCxxfio1Q3fKVjyptOyQhT4
 xVR3h7v7r/DXzQLZMFAHIBryhvujDx/w8/bxRhY6XGsuLWjgvAWXjCYySmp58U5qkvbF
 KFKGQePzoeqeNFTcAeWCHn48BiBorp8nLfVdUmalAP9gY3B9XVDAdjVz7Zp+wRp704xj
 f99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777315162; x=1777919962;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g/KHcZMmL5w/SgxdbTJ3+hx9/L0qu6MGRdeFCW9qtfk=;
 b=hDjvFiGrIvhdNiPAUe+eQTg9c/DgOAumnw+pu3GwDGXEx9f5T50X5f1f6tTmVJOTpu
 ZH0AvEYMVpD1Ls8tgac79tipMhxJD152EjU91WHDqpQeiyOLRyZmxeD8C7khsBV5yQIq
 Bm9IwOBYNlDsLNEAddYoE2s+da0J/lxa8RN4FWAofq/59mW1mBs9MgiZ/q7VyevAnZo8
 jyBtx2NtkBF7s8+pLHo2P7zqdlMRvM1DbeVz5SLlbYgwSdti6oSZrhhbps2AutYc49OF
 FnyUU0lYNJInnmWB3kJQ749icUX+nNHT6wDCZURdnacReZonWpjvUNfyulC5H2xKg/Q3
 9dmA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Owj0KotdALs3LxhVGSugNMkbP8syMnkXnwYd5XQrBvN4Vk1wuH+5+WcgIj7F67L/GtCE3mjEFNm0m@nongnu.org
X-Gm-Message-State: AOJu0Yxt5NLOMgEoPLB2xfxCQBRTRhohlyieL9R7fWDxsbGg/AdG7FJ6
 HrOmdYK6uko3btni0KrI1XKqsZQRQ3p1ZvMrYAxRndOvJ+YWl9pnZISsmHCb5gJ+kVkwCVae9kr
 lBsvayp0IMjSRTOR9V0szrHTnoJzIP7jp9Imw3HjV5OdgYIwEqf2CUAM7Ug==
X-Gm-Gg: AeBDiet+gWe555TJ4i79jT7YIvXfEr0dSZV2Roeub9Vx+qi8YulIEcdd/Gj1Gu9weG/
 Vg7u65fOQRXp3ybeLjynX+I0tMG+fjXIJAHl+qESWYyfN3i6xe0fkaKDkT55UMDwHo2Tr6pRMDC
 DGcU+jOwJ86VlhVshWRHKOMsxlh+53u3Zm6QWKAtgcgymf6qVExU35EGfJ45ToB7PNfnaGhT8Rz
 /WfsRzkrdV/SbDg49eV1DuCeDz+Nc+i6QiJOKe0sWHUQ4pMjDYyJ6DA6JdeK3DMMvpDZa7CF8CG
 nt+uiepMz9Ne4DwTpAPDvwWhB+VUWArNlxQcXnCm2/7+iR8WPbwZZQ4Q/0QaiL1+aHaxrWCJGWe
 F0k7hUJiap4YYYkzS0ff3MBR1Mx+JuXF5lkO5QPtCWq0h9G3D4pqR1ORySfZWP9M/EYlKGppx+G
 Phv5yY6k5hXMfOn51DFktC5zA9
X-Received: by 2002:a05:693c:2c97:b0:2c8:7172:3b7b with SMTP id
 5a478bee46e88-2ed0a0f0da4mr15085eec.18.1777315161811; 
 Mon, 27 Apr 2026 11:39:21 -0700 (PDT)
X-Received: by 2002:a05:693c:2c97:b0:2c8:7172:3b7b with SMTP id
 5a478bee46e88-2ed0a0f0da4mr15034eec.18.1777315160896; 
 Mon, 27 Apr 2026 11:39:20 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed09dd953asm126868eec.0.2026.04.27.11.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 11:39:20 -0700 (PDT)
Message-ID: <c4c6e1cd-1236-4bcb-9fab-a65b20304922@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 11:39:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] linux-user: Filter /proc/*/task/ to hide
 QEMU-internal threads
To: Ali Raza <elirazamumtaz@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, deller@gmx.de
References: <20260424-master-v2-0-8b50b5c063ed@gmail.com>
 <20260424-master-v2-1-8b50b5c063ed@gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260424-master-v2-1-8b50b5c063ed@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Zs3d7d7G c=1 sm=1 tr=0 ts=69efad5a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=NEAV23lmAAAA:8 a=ATUQrrtcNKivIgas8OMA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 5sVJHjkrBzlkl2zZ7lEnnTsEqeyybyoV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDE5OCBTYWx0ZWRfX7smDRSPCZJUW
 0nAaO7Kl/tQ7+amxmGxoMc2xVY8yt9kA2VYXuDnTfIcVvsllCu/qgqb8SU63D2Ie2jw6jiPwCPX
 Oh7XMM5Wh0LvbhvvhJfABLiyCuXNIcPw8xNHw4+O1dEhaWjeP/4qgxxt2Wlz/yCIhHQPxMcU4kr
 AhusYuB/Zs9RE7O8/YUatQAU/wfE0u9Mifa0IPPIRGRpMh0KFzQJjyh8+Wfxb4wj4s7DykoRO+v
 LHesFt6l9Bgh5igr5zYrxe8rGgBHcrM7sGG40m4x+buANDMUAi2iHq/n7gKWKTV7bDiQeQFzALi
 AIeWlO4UGJy5/FTJu3sT02cFZYWrnfn5P3dvwan1CrcodS1K5PuU+k+AzgvpMPaa/3hdxPL6Nob
 R/R4Aw1iFWwgO8TLh0M2mwIjT5POtDE4weeWgqwKzUB92mMo8AJ83a25L+1eowf3my+NwN6rKnc
 WPIjedxm2aFmKm5wZnw==
X-Proofpoint-GUID: 5sVJHjkrBzlkl2zZ7lEnnTsEqeyybyoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270198
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 4/23/2026 2:36 PM, Ali Raza wrote:
> When a guest process reads /proc/<pid>/task/ via getdents/getdents64,
> the host kernel returns directory entries for all host threads in the
> process, including QEMU-internal threads (RCU, TCG workers) that have
> no guest CPUState.  This causes problems for guest libraries like
> libcap's PSX that enumerate threads via /proc/self/task/ and send
> signals to each one -- signals sent to QEMU-internal threads are never
> handled, leading to deadlocks.
> 
> Add filtering to do_getdents() and do_getdents64() that detects when
> the fd refers to a /proc/<pid>/task/ directory and skips entries whose
> TID does not belong to a guest thread.  Guest thread TIDs are
> identified by iterating the CPU list via CPU_FOREACH(), matching the
> existing pattern used for /proc/self/stat num_threads.
> 
> This fixes the psx_test hang reported in containers using QEMU
> user-mode emulation for cross-architecture builds.
> 
> Resolves: https://github.com/AndrewGMorgan/libcap_mirror/issues/6
> Signed-off-by: Ali Raza (@locus-x64)
> 
> ---
> Changes in v2:
> - Use pid_t instead of long for the parsed tid in do_getdents() and
>   do_getdents64() (suggested by Helge Deller).
> - Replace the ad-hoc readlink-at-getdents check with fd_trans-based
>   tagging at open time, eliminating a TOCTOU race and a broad-prefix
>   match that also matched /proc/<pid>/task/<tid>/fd.
> - Retry sys_getdents when an entire host batch is filtered out, so
>   the guest does not see a false EOF.
> - Parse the dirent TID with qemu_strtoi() instead of strtol() so
>   out-of-range values cannot wrap silently into pid_t.
> ---
>  linux-user/fd-trans.c |   6 +
>  linux-user/fd-trans.h |  18 +++
>  linux-user/syscall.c  | 298 +++++++++++++++++++++++++++++++++++++-------------
>  3 files changed, 244 insertions(+), 78 deletions(-)
> 
> diff --git a/linux-user/fd-trans.c b/linux-user/fd-trans.c
> index 64dd0745d2..6bad892b78 100644
> --- a/linux-user/fd-trans.c
> +++ b/linux-user/fd-trans.c
> @@ -1881,3 +1881,9 @@ static abi_long host_to_target_data_inotify(void *buf, size_t len)
>  TargetFdTrans target_inotify_trans = {
>      .host_to_target_data = host_to_target_data_inotify,
>  };
> +
> +/*
> + * No callbacks: this trans entry is purely a marker to identify fds
> + * that refer to our own /proc/<pid>/task directory.  See getdents().
> + */
> +TargetFdTrans target_proc_pid_task_trans;
> diff --git a/linux-user/fd-trans.h b/linux-user/fd-trans.h
> index 3bbc15fa1f..76b8c35374 100644
> --- a/linux-user/fd-trans.h
> +++ b/linux-user/fd-trans.h
> @@ -142,4 +142,22 @@ extern TargetFdTrans target_signalfd_trans;
>  extern TargetFdTrans target_eventfd_trans;
>  extern TargetFdTrans target_timerfd_trans;
>  extern TargetFdTrans target_inotify_trans;
> +
> +/*
> + * Marker (no callbacks) used to tag fds that refer to /proc/<pid>/task
> + * for our own process.  Used by getdents to filter out QEMU-internal
> + * host threads (RCU, TCG workers) that have no guest CPUState.
> + */
> +extern TargetFdTrans target_proc_pid_task_trans;
> +
> +static inline bool fd_trans_is_proc_pid_task(int fd)
> +{
> +    if (fd < 0) {
> +        return false;
> +    }
> +
> +    QEMU_LOCK_GUARD(&target_fd_trans_lock);
> +    return fd < target_fd_max
> +           && target_fd_trans[fd] == &target_proc_pid_task_trans;
> +}
>  #endif
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index f4b74ad350..44f2cd851f 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -8870,6 +8870,7 @@ static int do_openat2(CPUArchState *cpu_env, abi_long dirfd,
>      }
>  
>      fd_trans_unregister(ret);
> +    maybe_tag_proc_pid_task(ret);
>      unlock_user(pathname, guest_pathname, 0);
>      return ret;
>  }
> @@ -9108,6 +9109,58 @@ static int host_to_target_cpu_mask(const unsigned long *host_mask,
>      return 0;
>  }
>  
> +/*
> + * If the freshly-opened host fd refers to our own /proc/<pid>/task
> + * directory, register a marker on it via fd_trans so getdents() can
> + * later filter out QEMU-internal host threads (RCU, TCG workers) that
> + * have no guest CPUState.  Tagging at open time (rather than at
> + * getdents time) avoids TOCTOU on the fd's resolved path and lets us
> + * piggy-back on the existing fd_trans infrastructure for dup/close.
> + */
> +static void maybe_tag_proc_pid_task(int fd)
> +{
> +    char link_path[64];
> +    char link_target[PATH_MAX];
> +    char expected[64];
> +    ssize_t len;
> +    int expected_len;
> +
> +    if (fd < 0) {
> +        return;
> +    }
> +
> +    snprintf(link_path, sizeof(link_path), "/proc/self/fd/%d", fd);
> +    len = readlink(link_path, link_target, sizeof(link_target) - 1);
> +    if (len < 0) {
> +        return;
> +    }
> +    link_target[len] = '\0';
> +
> +    expected_len = snprintf(expected, sizeof(expected),
> +                            "/proc/%d/task", getpid());
> +    if (expected_len > 0 && (ssize_t)expected_len == len
> +        && memcmp(link_target, expected, expected_len) == 0) {
> +        fd_trans_register(fd, &target_proc_pid_task_trans);
> +    }
> +}
> +
> +/*
> + * Check if a given host TID belongs to a guest thread by looking it up
> + * in the CPU list.  Must be called under RCU read lock.
> + */
> +static bool is_guest_tid(pid_t tid)
> +{
> +    CPUState *cpu;
> +
> +    CPU_FOREACH(cpu) {
> +        TaskState *ts = get_task_state(cpu);
> +        if (ts->ts_tid == tid) {
> +            return true;
> +        }
> +    }
> +    return false;
> +}
> +
>  #ifdef TARGET_NR_getdents
>  static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
>  {
> @@ -9116,78 +9169,123 @@ static int do_getdents(abi_long dirfd, abi_long arg2, abi_long count)
>      int hlen, hoff, toff;
>      int hreclen, treclen;
>      off_t prev_diroff = 0;
> +    bool filter_task = fd_trans_is_proc_pid_task(dirfd);
> +    bool stop = false;
>  
>      hdirp = g_try_malloc(count);
>      if (!hdirp) {
>          return -TARGET_ENOMEM;
>      }
>  
> -#ifdef EMULATE_GETDENTS_WITH_GETDENTS
> -    hlen = sys_getdents(dirfd, hdirp, count);
> -#else
> -    hlen = sys_getdents64(dirfd, hdirp, count);
> -#endif
> -
> -    hlen = get_errno(hlen);
> -    if (is_error(hlen)) {
> -        return hlen;
> -    }
> -
>      tdirp = lock_user(VERIFY_WRITE, arg2, count, 0);
>      if (!tdirp) {
>          return -TARGET_EFAULT;
>      }
>  
> -    for (hoff = toff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
> +    toff = 0;
> +    /*
> +     * Loop until we either produce a visible target entry, hit a
> +     * real EOF (host returns 0), or hit an error.  Without this
> +     * retry, a host batch consisting entirely of filtered entries
> +     * would be reported to the guest as EOF.
> +     */
> +    while (!stop) {
>  #ifdef EMULATE_GETDENTS_WITH_GETDENTS
> -        struct linux_dirent *hde = hdirp + hoff;
> +        hlen = sys_getdents(dirfd, hdirp, count);
>  #else
> -        struct linux_dirent64 *hde = hdirp + hoff;
> +        hlen = sys_getdents64(dirfd, hdirp, count);
>  #endif
> -        struct target_dirent *tde = tdirp + toff;
> -        int namelen;
> -        uint8_t type;
> +        hlen = get_errno(hlen);
> +        if (is_error(hlen)) {
> +            unlock_user(tdirp, arg2, 0);
> +            return hlen;
> +        }
> +        if (hlen == 0) {
> +            break; /* real EOF */
> +        }
>  
> -        namelen = strlen(hde->d_name);
> -        hreclen = hde->d_reclen;
> -        treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
> -        treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent));
> +        for (hoff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
> +#ifdef EMULATE_GETDENTS_WITH_GETDENTS
> +            struct linux_dirent *hde = hdirp + hoff;
> +#else
> +            struct linux_dirent64 *hde = hdirp + hoff;
> +#endif
> +            struct target_dirent *tde = tdirp + toff;
> +            int namelen;
> +            uint8_t type;
> +
> +            namelen = strlen(hde->d_name);
> +            hreclen = hde->d_reclen;
>  
> -        if (toff + treclen > count) {
>              /*
> -             * If the host struct is smaller than the target struct, or
> -             * requires less alignment and thus packs into less space,
> -             * then the host can return more entries than we can pass
> -             * on to the guest.
> +             * Filter /proc/<pid>/task/ listings to hide QEMU-internal
> +             * host threads (RCU, TCG) that have no guest CPUState.
>               */
> -            if (toff == 0) {
> -                toff = -TARGET_EINVAL; /* result buffer is too small */
> +            if (filter_task) {
> +                int tid_int;
> +                if (qemu_strtoi(hde->d_name, NULL, 10, &tid_int) == 0
> +                    && tid_int > 0) {
> +                    pid_t tid = (pid_t)tid_int;
> +                    bool drop;
> +
> +                    WITH_RCU_READ_LOCK_GUARD() {
> +                        drop = !is_guest_tid(tid);
> +                    }
> +                    if (drop) {
> +                        treclen = 0;
> +                        continue;
> +                    }
> +                }
> +            }
> +            treclen = offsetof(struct target_dirent, d_name) + namelen + 2;
> +            treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent));
> +
> +            if (toff + treclen > count) {
> +                /*
> +                 * If the host struct is smaller than the target struct, or
> +                 * requires less alignment and thus packs into less space,
> +                 * then the host can return more entries than we can pass
> +                 * on to the guest.
> +                 */
> +                if (toff == 0) {
> +                    toff = -TARGET_EINVAL; /* result buffer is too small */
> +                    stop = true;
> +                    break;
> +                }
> +                /*
> +                 * Return what we have, resetting the file pointer to the
> +                 * location of the first record not returned.
> +                 */
> +                lseek(dirfd, prev_diroff, SEEK_SET);
> +                stop = true;
>                  break;
>              }
> +
> +            prev_diroff = hde->d_off;
> +            tde->d_ino = tswapal(hde->d_ino);
> +            tde->d_off = tswapal(hde->d_off);
> +            tde->d_reclen = tswap16(treclen);
> +            memcpy(tde->d_name, hde->d_name, namelen + 1);
> +
>              /*
> -             * Return what we have, resetting the file pointer to the
> -             * location of the first record not returned.
> +             * The getdents type is in what was formerly a padding byte at the
> +             * end of the structure.
>               */
> -            lseek(dirfd, prev_diroff, SEEK_SET);
> -            break;
> +#ifdef EMULATE_GETDENTS_WITH_GETDENTS
> +            type = *((uint8_t *)hde + hreclen - 1);
> +#else
> +            type = hde->d_type;
> +#endif
> +            *((uint8_t *)tde + treclen - 1) = type;
>          }
>  
> -        prev_diroff = hde->d_off;
> -        tde->d_ino = tswapal(hde->d_ino);
> -        tde->d_off = tswapal(hde->d_off);
> -        tde->d_reclen = tswap16(treclen);
> -        memcpy(tde->d_name, hde->d_name, namelen + 1);
> -
>          /*
> -         * The getdents type is in what was formerly a padding byte at the
> -         * end of the structure.
> +         * If we produced any visible target entry, return; otherwise
> +         * loop again to fetch more host entries (avoid false EOF).
>           */
> -#ifdef EMULATE_GETDENTS_WITH_GETDENTS
> -        type = *((uint8_t *)hde + hreclen - 1);
> -#else
> -        type = hde->d_type;
> -#endif
> -        *((uint8_t *)tde + treclen - 1) = type;
> +        if (toff != 0) {
> +            break;
> +        }
>      }
>  
>      unlock_user(tdirp, arg2, toff);
> @@ -9203,57 +9301,99 @@ static int do_getdents64(abi_long dirfd, abi_long arg2, abi_long count)
>      int hlen, hoff, toff;
>      int hreclen, treclen;
>      off_t prev_diroff = 0;
> +    bool filter_task = fd_trans_is_proc_pid_task(dirfd);
> +    bool stop = false;
>  
>      hdirp = g_try_malloc(count);
>      if (!hdirp) {
>          return -TARGET_ENOMEM;
>      }
>  
> -    hlen = get_errno(sys_getdents64(dirfd, hdirp, count));
> -    if (is_error(hlen)) {
> -        return hlen;
> -    }
> -
>      tdirp = lock_user(VERIFY_WRITE, arg2, count, 0);
>      if (!tdirp) {
>          return -TARGET_EFAULT;
>      }
>  
> -    for (hoff = toff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
> -        struct linux_dirent64 *hde = hdirp + hoff;
> -        struct target_dirent64 *tde = tdirp + toff;
> -        int namelen;
> +    toff = 0;
> +    /*
> +     * Loop until we either produce a visible target entry, hit a
> +     * real EOF (host returns 0), or hit an error.  Without this
> +     * retry, a host batch consisting entirely of filtered entries
> +     * would be reported to the guest as EOF.
> +     */

It seems like this patch does two different things:
- fix issue when all entries are filtered
- add mechanic to filter non-guest threads

It would be more reviewable to implement this in two different patches.

> +    while (!stop) {
> +        hlen = get_errno(sys_getdents64(dirfd, hdirp, count));
> +        if (is_error(hlen)) {
> +            unlock_user(tdirp, arg2, 0);
> +            return hlen;
> +        }
> +        if (hlen == 0) {
> +            break; /* real EOF */
> +        }
> +
> +        for (hoff = 0; hoff < hlen; hoff += hreclen, toff += treclen) {
> +            struct linux_dirent64 *hde = hdirp + hoff;
> +            struct target_dirent64 *tde = tdirp + toff;
> +            int namelen;
>  
> -        namelen = strlen(hde->d_name) + 1;
> -        hreclen = hde->d_reclen;
> -        treclen = offsetof(struct target_dirent64, d_name) + namelen;
> -        treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent64));
> +            namelen = strlen(hde->d_name) + 1;
> +            hreclen = hde->d_reclen;
>  
> -        if (toff + treclen > count) {
>              /*
> -             * If the host struct is smaller than the target struct, or
> -             * requires less alignment and thus packs into less space,
> -             * then the host can return more entries than we can pass
> -             * on to the guest.
> +             * Filter /proc/<pid>/task/ listings to hide QEMU-internal
> +             * host threads (RCU, TCG) that have no guest CPUState.
>               */
> -            if (toff == 0) {
> -                toff = -TARGET_EINVAL; /* result buffer is too small */
> +            if (filter_task) {
> +                int tid_int;
> +                if (qemu_strtoi(hde->d_name, NULL, 10, &tid_int) == 0
> +                    && tid_int > 0) {
> +                    pid_t tid = (pid_t)tid_int;
> +                    bool drop;
> +
> +                    WITH_RCU_READ_LOCK_GUARD() {
> +                        drop = !is_guest_tid(tid);
> +                    }
> +                    if (drop) {
> +                        treclen = 0;
> +                        continue;
> +                    }
> +                }
> +            }
> +            treclen = offsetof(struct target_dirent64, d_name) + namelen;
> +            treclen = QEMU_ALIGN_UP(treclen, __alignof(struct target_dirent64));
> +
> +            if (toff + treclen > count) {
> +                /*
> +                 * If the host struct is smaller than the target struct, or
> +                 * requires less alignment and thus packs into less space,
> +                 * then the host can return more entries than we can pass
> +                 * on to the guest.
> +                 */
> +                if (toff == 0) {
> +                    toff = -TARGET_EINVAL; /* result buffer is too small */
> +                    stop = true;
> +                    break;
> +                }
> +                /*
> +                 * Return what we have, resetting the file pointer to the
> +                 * location of the first record not returned.
> +                 */
> +                lseek(dirfd, prev_diroff, SEEK_SET);
> +                stop = true;
>                  break;
>              }
> -            /*
> -             * Return what we have, resetting the file pointer to the
> -             * location of the first record not returned.
> -             */
> -            lseek(dirfd, prev_diroff, SEEK_SET);
> -            break;
> +
> +            prev_diroff = hde->d_off;
> +            tde->d_ino = tswap64(hde->d_ino);
> +            tde->d_off = tswap64(hde->d_off);
> +            tde->d_reclen = tswap16(treclen);
> +            tde->d_type = hde->d_type;
> +            memcpy(tde->d_name, hde->d_name, namelen);
>          }
>  
> -        prev_diroff = hde->d_off;
> -        tde->d_ino = tswap64(hde->d_ino);
> -        tde->d_off = tswap64(hde->d_off);
> -        tde->d_reclen = tswap16(treclen);
> -        tde->d_type = hde->d_type;
> -        memcpy(tde->d_name, hde->d_name, namelen);
> +        if (toff != 0) {
> +            break;
> +        }
>      }
>  
>      unlock_user(tdirp, arg2, toff);
> @@ -9732,6 +9872,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>                                    target_to_host_bitmask(arg2, fcntl_flags_tbl),
>                                    arg3, true));
>          fd_trans_unregister(ret);
> +        maybe_tag_proc_pid_task(ret);
>          unlock_user(p, arg1, 0);
>          return ret;
>  #endif
> @@ -9742,6 +9883,7 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
>                                    target_to_host_bitmask(arg3, fcntl_flags_tbl),
>                                    arg4, true));
>          fd_trans_unregister(ret);
> +        maybe_tag_proc_pid_task(ret);
>          unlock_user(p, arg2, 0);
>          return ret;
>      case TARGET_NR_openat2:
> 

Else, the logic of the patch seems correct to me, tagging fd for
/proc/*/task and reusing this information for getdents* to decide to
filter a specific entry or not.

I guess it does not protect from opening directly a specific thread
file, but there is no reason someone knows the id without performing a
getdents first.

Regards,
Pierrick

